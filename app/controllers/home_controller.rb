class HomeController < ApplicationController
  def index
    @blogs = Blog.order('created_at').all
    @preview = Blog.order('created_at DESC').limit(3).all
  end
  def about
    @preview = Blog.order('created_at').limit(3).all
  end
  def map
    @preview = Blog.order('created_at').limit(3).all
  end
end
