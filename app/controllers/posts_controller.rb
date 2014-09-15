class PostsController < ApplicationController
	before_action :authenticate_user!, except: [:index]

	def index
		@posts = Post.all
	end

	def new
		@post = Post.new
	end

	def create
		@post = Post.new post_params
		@post.user = current_user
		@post.blog = Blog.find params[:blog_id]
		@post.save!
		
		redirect_to blog_path(@post.blog.id)
	end

	def edit
		@post = Post.find params[:id]
	end

	def update
		@post = Post.find params[:id]
		@post.blog = Blog.find params[:blog_id]
		@post.update post_params
		flash[:notice] = "Post successfully updated"
    redirect_to blog_path(@post.blog.id)
	end

	def destroy
		@post = Post.find params[:id]
		@post.destroy
		redirect_to blog_posts_path
		flash[:notice] = "Post successfully deleted"
	end
	
	def post_params
		params.require(:post).permit(:title, :description)
	end
end