require 'rails_helper'

def sign_out
	visit '/blogs'
	click_link 'Sign out'
end
