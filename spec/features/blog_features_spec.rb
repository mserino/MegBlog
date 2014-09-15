require 'rails_helper'
require 'database_cleaner'

# User can have multiple blogs, a blog can have multiple posts

describe 'Blog' do

	context 'no blogs' do
		let(:user) {create(:user)}
		
		it 'there is no blog' do
			login_as user
			visit '/blogs'
			expect(page).to have_content 'No blog'
		end
	end

	context 'with blogs' do
		let(:user) {create(:user)}
		before do
			login_as user
			user.blogs.create title: "Aftermakers", description: "What I will learn after"
		end

		def sign_out
			visit '/blogs'
			click_link 'Sign out'
		end

		it 'shows the name of the blog' do
			visit '/blogs'
			expect(page).to have_content 'Aftermakers'
		end

		it 'shows the description' do
			visit '/blogs'
			expect(page).to have_content 'What I will learn after'
		end

		it 'cannot create the blog if signed out' do
			sign_out
			visit '/blogs'
			expect(page).to have_content 'You must be logged in to create new blogs'
			expect(page).not_to have_content "Add a new blog"
		end

		it 'can create a new blog only if signed in' do
			visit '/blogs'
			click_link "Add a new blog"
			expect(current_path).to eq new_blog_path
			fill_in "Title", with: "Koalas"
			fill_in "Description", with: "Let's use all the animals in the world"
			click_button "Submit"
			expect(page).to have_content "Koalas"
			expect(page).to have_content "Aftermakers"
		end

		it 'can create a post' do
			visit '/blogs'
			click_link "Aftermakers"
			click_link "New post"
			fill_in 'Title', with: "This is my new post"
			fill_in 'Description', with: "Let's see what happens"
			click_button 'Submit'
			expect(page).to have_content "This is my new post"
		end
	end
end