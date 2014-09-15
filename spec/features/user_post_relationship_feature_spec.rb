require 'rails_helper'

describe 'User has a post' do
	context 'logged in as the creator of the post' do
		let(:janedoe) { create(:user) }
		before do
			blog = Blog.create title: "Pandas", description: "Blog about pandas"
			login_as janedoe
			visit '/blogs'
			click_link 'Pandas'
			click_link 'New post'
			fill_in 'Title', with: "This is my new post"
			fill_in 'Description', with: "Let's see what happens"
			click_button 'Submit'
		end

		it 'shows the name of the creator' do
			visit '/blogs/1/posts'
			expect(page).to have_content 'Posted by test@test.com'
		end
	end
end