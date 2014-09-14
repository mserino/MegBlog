require 'rails_helper'

describe 'Posts' do
	context 'no posts' do
		it 'there are no posts' do
			visit '/posts'
			expect(page).to have_content "No posts yet :("
		end
	end

	context 'with posts' do
		let(:jack) { create(:user) }
		before do
			jack.posts.create title: 'First post', description: 'this is my first post ever'
		end

		it 'post has a title' do
			visit '/posts'
			expect(page).to have_content 'First post'
		end

		it 'post has a description' do
			visit '/posts'
			expect(page).to have_content 'this is my first post ever'
		end
	end
end