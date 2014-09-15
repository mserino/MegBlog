require 'rails_helper'

describe "Blog-User" do
	context 'logged in as the creator of the blog' do
		let(:user) { create(:user) }
		before do
			login_as user
			user.blogs.create title: "Cheetas", description: "A blog about cheetas"
		end

		it 'shows the list of all the user\'s blogs' do
			visit '/'
			expect(page).to have_content "Cheetas (test@test.com)"
		end
	end
end