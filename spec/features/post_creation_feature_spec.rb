require 'rails_helper'

describe 'Post creation' do
	before do
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
end