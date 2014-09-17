module CapybaraHelper
	
	def create_post
		visit blog_path(@blog.id)
		click_link "New post"
		fill_in "Title", with: "Title of the post"
		fill_in "Description", with: "Description of the post"
		click_button "Submit"
	end

	def create_second_post
		visit blog_path(@blog.id)
		click_link "New post"
		fill_in "Title", with: "Second post"
		fill_in "Description", with: "This is post number two"
		click_button "Submit"
	end

	def sign_out
		visit '/blogs'
		click_link 'Sign out'
	end

end