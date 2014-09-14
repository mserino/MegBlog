require 'rails_helper'

describe 'Creating, editing and deleting posts' do

	context 'while signed out' do
		before do
			Post.create title: "Post", description: "Hello I'm a new post"
		end

		it 'cannot create new posts' do
			visit '/'
			expect(page).to have_content 'You must be logged in to add new posts'
		end

		it 'cannot create new posts at all' do
			visit '/posts/new'
			expect(page).to have_content 'You need to sign in or sign up before continuing.'
		end

		it 'cannot edit posts' do
			visit '/posts'
			click_link 'Edit post'
			expect(page).to have_content 'You need to sign in or sign up before continuing.'
		end

		it 'cannot delete posts' do
			visit '/posts'
			click_link 'Delete post'
			expect(page).to have_content 'You need to sign in or sign up before continuing.'
		end
	end

	context 'while signed in' do
		let(:johndoe) { create(:user) }

		before do
			login_as johndoe

			visit '/posts/new'
			fill_in 'Title', with: 'Yo'
			fill_in 'Description', with: 'I am a superverycool post'
			click_button 'Submit'
		end

		it 'can create a post' do
			expect(current_path).to eq posts_path
			expect(page).to have_content 'Yo'
			expect(page).to have_content 'I am a superverycool post'
		end

		it 'can edit a post' do
			visit '/posts'
			click_link 'Edit post'
			fill_in 'Title', with: 'Try again'
			click_button 'Submit'
			expect(current_path).to eq posts_path
			expect(page).to have_content 'Try again'
			expect(page).not_to have_content 'Yo'
			expect(page).to have_content 'Post successfully updated'
		end

		it 'can delete a post' do
			visit '/posts'
			click_link 'Delete post'
			expect(page).not_to have_content 'Yo'
			expect(page).to have_content 'Post successfully deleted'
		end
	end
end