require 'facets/string/snakecase'

class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]

  # GET /blogs
  # GET /blogs.json
  def index
    @blogs = Blog.order('created_at').all
    @preview = Blog.order('created_at DESC').limit(3).all
  end

  # GET /blogs/:name
  # GET /blogs/:name.json
  def show
    @blogs = Blog.order('created_at').all
    @preview = Blog.order('created_at DESC').limit(3).all
  end

  # GET /blogs/new
  def new
    @blogs = Blog.order('created_at').all
    @preview = Blog.order('created_at DESC').limit(3).all
  end

  # GET /blogs/:name/edit
  def edit
    @blogs = Blog.order('created_at').all
    @preview = Blog.order('created_at DESC').limit(3).all
  end

  # POST /blogs
  # POST /blogs.json
  def create
    blog = blog_params
    blog["name"] = blog[:title].snakecase 
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
      blog["name"] = blog[:title].snakecase 
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find_by_name(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_params
      params.require(:blog).permit(:article, :title, :name, :image, :date, :lat, :lng)
    end
end
