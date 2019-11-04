require 'rails_helper'

RSpec.describe 'the registration page' do
  describe 'happy path' do
    it 'should create new user after filling out the form' do
      visit registration_path

      fill_in :user_first_name, with: "First"
      fill_in :user_last_name, with: "Last"
      fill_in :user_email, with: "user@email.com"
      fill_in :user_password, with: "password"
      fill_in :user_password_confirmation, with: "password"

      click_button "Submit"

      expect(current_path).to eq(profile_path)

      user = User.last

      expect(page).to have_content("Registration Successful! You are now logged in.")
    end
  end
end
