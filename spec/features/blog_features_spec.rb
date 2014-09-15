require 'rails_helper'

# User can have multiple blogs, a blog can have multiple posts

describe 'Blog' do
	context 'no blogs' do
		it 'there is no blog' do
			visit '/blogs'
			expect(page).to have_content 'No blog'
		end
	end

	context 'with blogs' do
		let(:user) {create(:user)}
		before do
			login_as user
			Blog.create title: "Aftermakers", description: "What I will learn after"
		end

		it 'shows the name of the blog' do
			visit '/blogs'
			expect(page).to have_content 'Aftermakers'
		end

		it 'shows the description' do
			visit '/blogs'
			expect(page).to have_content 'What I will learn after'
		end

		it 'can create a post' do
			visit '/blogs/1/posts/new'
				fill_in 'Title', with: "This is my new post"
				fill_in 'Description', with: "Let's see what happens"
				click_button 'Submit'
			expect(page).to have_content "This is my new post"
		end
	end
end