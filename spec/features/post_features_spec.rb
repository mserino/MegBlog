require 'rails_helper'

describe 'Posts' do
	context 'no posts' do

		before do
			blog = Blog.create title: "Pandas", description: "Blog about pandas"
		end

		it 'there are no posts' do
			visit '/blogs/1/posts'
			expect(page).to have_content "No posts yet :("
		end
	end

	context 'with posts' do
		let(:jack) { create(:user) }
		before do
			blog = Blog.create title: "Pandas", description: "Blog about pandas"
			login_as jack
			visit '/blogs'
			click_link 'Pandas'
			click_link 'New post'
			fill_in 'Title', with: "This is my new post"
			fill_in 'Description', with: "Let's see what happens"
			click_button 'Submit'
		end

		it 'post has a title' do
			visit '/blogs/1/posts'
			expect(page).to have_content 'This is my new post'
		end

		it 'post has a description' do
			visit '/blogs/1/posts'
			expect(page).to have_content "Let's see what happens"
		end
	end
end

		# let(:cindy) { create(:user) }

		# before do
		# 	blog = Blog.create title: "Pandas", description: "Blog about pandas"
		# 	login_as cindy
		# 	visit '/blogs'
		# 	click_link 'Pandas'
		# 	click_link 'New post'
		# 		fill_in 'Title', with: "This is my new post"
		# 		fill_in 'Description', with: "Let's see what happens"
		# 		click_button 'Submit'
		# end