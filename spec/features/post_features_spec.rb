require 'rails_helper'

describe 'Posts' do
	it 'there are no posts' do
		visit '/posts'
		expect(page).to have_content "No posts yet :("
	end
end