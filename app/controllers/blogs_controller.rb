class BlogsController < ApplicationController
	before_action :authenticate_user!, except: [:index]

	def index
		@blogs = Blog.all
		@users = User.all
	end

	def show
		@blog = Blog.find params[:id]
		@posts = Post.all
		redirect_to blog_posts_path(@blog.id)
	end

	def new
		@blog = Blog.new
	end

	def create
		@blog = Blog.new blog_params
		@blog.user = current_user
		@blog.save!
		redirect_to blogs_path
	end


	def blog_params
		params.require(:blog).permit(:title, :description)
	end
end
