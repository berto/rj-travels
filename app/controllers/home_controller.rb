require 'aws-sdk'

class HomeController < ApplicationController
  before_action :set_preview, only: [:index, :about, :gallery, :map, :country]

  def index
    @blogs = Blog.order('created_at').all
  end

  def about
  end

  def gallery
  end

  def country
    @country = params[:country]
    bucket = @country + '-rj-travels'
    resp = @s3.list_objects(bucket: bucket)
    @pictures = []
    resp.contents.each do |object|
      if (!object.key.ends_with? "/") && (!object.key.downcase.include? "cover") && (!object.key.downcase.include? "default")
        image_name = format_image_name(object.key)
        picture = { :link => 'https://s3.amazonaws.com/' + bucket + '/' + object.key, :name => image_name }
        @pictures.push(picture)
      end
    end
  end

  def map
    @blogs = Blog.all.where("lat is not null")
    blog_markers = group_blogs(@blogs)
    @blogs = Gmaps4rails.build_markers(blog_markers) do |blog, marker|
      marker.infowindow format_window(blog[:posts])    
      marker.lat blog[:lat]
      marker.lng blog[:lng]
    end
  end

  private
    def set_preview
      @preview = Blog.order('created_at DESC').limit(3).all
      Aws.config.update({
        region: 'us-east-1',
        credentials: Aws::Credentials.new(ENV['AWS_ID'], ENV['AWS_SECRET'])
      })
      @s3 = Aws::S3::Client.new
      resp = @s3.list_buckets
      resp.buckets.map { |bucket| puts bucket.inspect } 
      @countries = resp.buckets.map { |bucket| bucket.name.split('-')[0] } 
    end
    def group_blogs(blogs)
      group = []
      blogs.reverse.each do |blog|
        @added = false
        group.each do |marker|
          if (marker[:lat] == blog[:lat]) && (marker[:lng] == blog[:lng])
            marker[:posts].push(blog)
            @added = true
          end
        end
        if (!@added)
          marker = {:posts => [], :lat => blog.lat, :lng => blog.lng}
          marker[:posts].push(blog)
          group.push(marker)
        end
      end
      group
    end
    def format_window(posts)
      marker = '<div class="window">'
      posts.each do |post|
        image = '' 
        if (!post.image.empty?)
          image = '<img src="' + post.image + '">'
        end
        title = '<h2>' + post.title + '</h2>'
        date = '<h6>' + post.date.strftime("%m/%d/%y") + '</h6>'
        preview = '<p >' + truncate(post.article) + '</p>'
        link = '<a href="/blogs/' + post.name + '"><button>More</button></a>'
        marker += title + image + date + preview + link + '<hr>'
      end
      marker + '</div>'
    end
    def truncate(s, length = 100, ellipsis = '...')
      if s.length > length
        s.to_s[0..length].gsub(/[^\w]\w+\s*$/, ellipsis)
      else
        s
      end
    end
    def format_image_name(name)
      name.split('/')[-1].chomp('.jpg').chomp('.JPG')
    end
end
