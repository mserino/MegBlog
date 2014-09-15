require 'rails_helper'

describe 'Creating, editing and deleting posts' do

	context 'while signed out' do
		let(:cindy) { create(:user) }
		before do
			Blog.create title: "Pandas", description: "Blog about pandas"
			login_as cindy
			visit '/blogs'
			click_link 'Pandas'
			click_link 'New post'
				fill_in 'Title', with: "This is my new post"
				fill_in 'Description', with: "Let's see what happens"
				click_button 'Submit'
		end

		def sign_out
			visit '/'
			click_link 'Sign out'
		end

		it 'cannot create new posts' do
			sign_out
			visit '/blogs'
			click_link "Pandas"
			expect(page).to have_content 'You must be logged in to add new posts'
		end

		it 'cannot create new posts at all' do
			sign_out
			visit '/blogs'
			click_link "Pandas"
			click_link "New post"
			expect(page).to have_content 'You need to sign in or sign up before continuing.'
		end

		it 'cannot edit posts' do
			visit '/blogs/1/posts'
			click_link 'Edit post'
			expect(page).to have_content 'You need to sign in or sign up before continuing.'
		end

		it 'cannot delete posts' do
			visit '/blogs/1/posts'
			click_link 'Delete post'
			expect(page).to have_content 'You need to sign in or sign up before continuing.'
		end
	end

	context 'while signed in' do
		let(:johndoe) { create(:user) }

		before do
			login_as johndoe

			visit '/blogs/1/posts/new'
			fill_in 'Title', with: 'Yo'
			fill_in 'Description', with: 'I am a superverycool post'
			click_button 'Submit'
		end

		it 'can create a post' do
			expect(current_path).to eq blog_posts_path
			expect(page).to have_content 'Yo'
			expect(page).to have_content 'I am a superverycool post'
		end

		it 'can edit a post' do
			visit '/blogs/1/posts'
			click_link 'Edit post'
			fill_in 'Title', with: 'Try again'
			click_button 'Submit'
			expect(current_path).to eq blog_posts_path
			expect(page).to have_content 'Try again'
			expect(page).not_to have_content 'Yo'
			expect(page).to have_content 'Post successfully updated'
		end

		it 'can delete a post' do
			visit '/blogs/1/posts'
			click_link 'Delete post'
			expect(page).not_to have_content 'Yo'
			expect(page).to have_content 'Post successfully deleted'
		end
	end
end