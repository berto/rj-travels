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
      if !object.key.ends_with? "/"
        @pictures.push('https://s3.amazonaws.com/' + bucket + '/' + object.key)
      end
    end
  end

  def map
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
end
