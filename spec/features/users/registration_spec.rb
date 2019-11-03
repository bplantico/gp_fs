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

  describe 'sad path' do
    it "should display error messages for each unfilled field" do
      visit registration_path

      click_button "Submit"

      expect(current_path).to eq(registration_path)

      expect(page).to have_content("First name can't be blank")
      expect(page).to have_content("Last name can't be blank")
      expect(page).to have_content("Email can't be blank")
      expect(page).to have_content("Password can't be blank")
    end

    it "should display an error when an email is taken" do
      user = create(:user)
      user.update(email: "example@gmail.com")

      visit registration_path

      fill_in :user_first_name, with: "first_1"
      fill_in :user_last_name, with: "last_1"
      fill_in :user_email, with: "example@gmail.com"
      fill_in :user_password, with: "password"
      fill_in :user_password_confirmation, with: "password"

      click_button "Submit"

      expect(current_path).to eq(registration_path)
      expect(page).to have_content("Email has already been taken")

      expect(page).to have_css("input[value='first_1']")
      expect(page).to have_css("input[value='last_1']")

      expect(page).to_not have_css("input[value='example@gmail.com']")
      expect(page).to_not have_css("input[value='password']")
    end

    it "should display an error when password confirmation doesn't match" do
      visit registration_path

      fill_in :user_first_name, with: "first"
      fill_in :user_first_name, with: "last"

      fill_in :user_email, with: "example@gmail.com"
      fill_in :user_password, with: "password"
      fill_in :user_password_confirmation, with: "a different password"

      click_button "Submit"

      expect(current_path).to eq(registration_path)
      expect(page).to have_content("Password confirmation doesn't match Password")
    end
  end
end
