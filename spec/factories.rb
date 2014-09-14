# This will guess the User class
FactoryGirl.define do
  factory :user do
    email "test@test.com"
    password  "1234567890"
    password_confirmation "1234567890"
  end

  # johndoe = create(:user)

  # This will use the User class (Admin would have been guessed)
  # factory :admin, class: User do
  #   first_name "Admin"
  #   last_name  "User"
  #   admin      true
  # end
end