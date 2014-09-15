module BlogsHelper
	def owner?
		current_user.id == @blog.user_id
	end
end