module BlogsHelper
	def owner?
		current_user.id == @blog.user_id if current_user
	end
end