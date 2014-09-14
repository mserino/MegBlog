require 'rails_helper'

describe 'Post creation' do
	it 'can create a post' do
		visit '/posts/new'
		fill_in 'Title', with: 'Yo'
		fill_in 'Description', with: 'I am a superverycool post'
		click_button 'Submit'
		expect(current_path).to eq posts_path
		expect(page).to have_content 'Yo'
		expect(page).to have_content 'I am a superverycool post'
	end
end