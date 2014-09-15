class BlogsController < ApplicationController

	def index
		@blogs = Blog.all
	end

	def show
		@blog = Blog.find params[:id]
		@posts = Post.all
	end

	def new
		@blog = Blog.new
	end

	def create
		@blog = Blog.new blog_params
		@blog.save!
		redirect_to blogs_path
	end


	def blog_params
		params.require(:blog).permit(:title, :description)
	end
end
