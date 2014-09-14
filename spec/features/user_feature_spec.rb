require 'rails_helper'

describe 'User' do
	context 'not existing user' do
		it 'can sign up' do
			visit '/users/sign_up'
			within '.new_user' do
				fill_in 'Email', with: 'email@megblog.com'
				fill_in 'Password', with: '1234567890'
				fill_in 'Password confirmation', with: '1234567890'
			end
			click_button 'Sign up'
			expect(page).to have_content 'Welcome email@megblog.com'
		end
	end
	context 'existing user' do
		before do
			User.create(email: 'test@test.com', password: '12345678', password_confirmation: '12345678')
			visit '/users/sign_in'
			within '.new_user' do
				fill_in 'Email', with: 'test@test.com'
				fill_in 'Password', with: '12345678'
				click_button 'Log in'
			end
		end

		it 'can sign in' do
			expect(page).to have_content 'Welcome test@test.com'
		end

		it 'can sign out' do
			click_link 'Sign out'
			expect(page).to have_content 'Sign in'
			expect(current_path).to eq '/'
		end
	end
end