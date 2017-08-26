class AuthController < ApplicationController
  skip_before_action :verify_authenticity_token
  # GET /login
  def login
    @preview = Blog.order('created_at DESC').limit(3).all
    @countries = []
  end

  # POST /login
  def create_session
    respond_to do |format|
      if params[:password] == ENV["PASSWORD"]
        cookies.signed[:login] = true
        puts cookies.signed[:login]
        format.html { redirect_to blogs_url }
      else
        format.html { redirect_to :login }
      end
    end
  end

  # GET /logout
  def logout
    cookies.delete :login
    respond_to do |format|
      format.html { redirect_to root_url }
    end
  end
end
