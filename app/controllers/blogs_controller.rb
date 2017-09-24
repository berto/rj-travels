require 'facets/string/snakecase'
require 'aws-sdk'

class BlogsController < ApplicationController
  before_action :authorize, except: [:feed, :index, :show]
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  before_action :set_preview, only: [:index, :show, :new, :edit]

  # GET /blogs
  # GET /blogs.json
  def index
    @blogs = Blog.order('created_at').all
  end

  # GET /blogs/:name
  # GET /blogs/:name.json
  def show
    @blogs = Blog.order('created_at').all
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
  end

  # GET /blogs/:name/edit
  def edit
    @blogs = Blog.order('created_at').all
  end

  # POST /blogs
  # POST /blogs.json
  def create
    blog = blog_params
    blog["name"] = blog[:title].gsub(".","").snakecase 
    @blog = Blog.new(blog)

    respond_to do |format|
      if @blog.save
        format.html { redirect_to @blog, notice: 'Blog was successfully created.' }
        format.json { render :show, status: :created, location: @blog.name }
      else
        format.html { render :new }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogs/:name
  # PATCH/PUT /blogs/:name.json
  def update
    respond_to do |format|
      blog = blog_params
      blog["name"] = blog[:title].gsub(".","").snakecase 
      if @blog.update(blog)
        format.html { redirect_to @blog, notice: 'Blog was successfully updated.' }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/:name
  # DELETE /blogs/:name.json
  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url, notice: 'Blog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def feed
    @blogs = Blog.order('created_at').all
    respond_to do |format|
      format.rss { render :layout => false }
    end
  end

  private
    def authorize
      if cookies.signed[:login].blank?
        respond_to do |format|
          format.html { redirect_to blogs_url, notice: 'Must be logged in.' }
        end
      end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find_by_name(params[:id])
    end

    def set_preview
      @blog = Blog.find_by_name(params[:id])
      @preview = Blog.order('created_at DESC').limit(3).all
      Aws.config.update({
        region: 'us-east-1',
        credentials: Aws::Credentials.new(ENV['AWS_ID'], ENV['AWS_SECRET'])
      })
      s3 = Aws::S3::Client.new
      resp = s3.list_buckets
      resp.buckets.map { |bucket| puts bucket.inspect } 
      @countries = resp.buckets.map { |bucket| bucket.name.split('-')[0] } 
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_params
      params.require(:blog).permit(:article, :title, :name, :image, :date, :lat, :lng)
    end
end
