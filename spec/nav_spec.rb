require 'rails_helper'

RSpec.describe 'Site Nav', type: :feature do
  before :each do
    @user = create(:user)

    @garden = create(:garden, user: @user)
  end

  it 'should show proper links for all visitors' do

    visit root_path

    click_link 'Log in'
    expect(current_path).to eq(login_path)

    click_link 'Register'
    expect(current_path).to eq(registration_path)

    click_link 'GardenPi'
    expect(current_path).to eq(root_path)

    expect(page).to_not have_link('Log out')
    expect(page).to_not have_link('Profile')
    expect(page).to_not have_link('Gardens')

    visit profile_path
    expect(page.status_code).to eq(404)
  end

  it 'should show proper links for all users logged in' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit root_path

    click_link 'Profile'
    expect(current_path).to eq(profile_path)

    click_link 'Gardens'
    expect(current_path).to eq(profile_gardens_path)

    click_link 'Log out'
    expect(current_path).to eq(root_path)

    expect(page).to_not have_link('Log in')
    expect(page).to_not have_link('Register')
  end
end
