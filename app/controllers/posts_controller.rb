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
		@post.save!
		
		redirect_to posts_path
	end

	def edit
		@post = Post.find params[:id]
	end

	def update
		@post = Post.find params[:id]
		@post.update post_params
		flash[:notice] = "Post successfully updated"
    redirect_to posts_path
	end

	def post_params
		params.require(:post).permit(:title, :description)
	end

	def destroy
		@post = Post.find params[:id]
		@post.destroy
		redirect_to posts_path
		flash[:notice] = "Post successfully deleted"
	end
end