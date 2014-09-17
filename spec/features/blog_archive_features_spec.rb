require 'rails_helper'

describe 'Blog Archive' do
	let(:emma) { create(:user) }
	before do
		@blog = emma.blogs.create(title: "Coderita", description: "Coding for brazilian parrots")
		login_as emma
		create_post
	end

	it 'shows the list of all the posts' do
		within('#archive') do
			expect(page).to have_content 'Title of the post'
		end
	end

	it 'takes to the page of the single post if clicked' do
		create_second_post
		within('#archive') do
			click_link "Title of the post"
		end
		expect(page).to have_content "Description of the post"
		expect(page).not_to have_content "This is post number two"
	end
end