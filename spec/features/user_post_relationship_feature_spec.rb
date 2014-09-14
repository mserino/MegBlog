require 'rails_helper'

describe 'User has a post' do
	context 'logged in as the creator of the post' do
		let(:janedoe) { create(:user) }
		before do
			janedoe.posts.create title: 'I am janedoe', description: 'And this is my post'
		end

		it 'shows the name of the creator' do
			visit '/posts'
			expect(page).to have_content 'Posted by test@test.com'
		end
	end
end