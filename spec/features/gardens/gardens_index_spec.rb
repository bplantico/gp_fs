require 'rails_helper'

describe "as a logged in and registered user on my profile page" do
  describe "I click the gardens navbar link" do
		before :each do
	    @user_1 = create(:user)	
      @garden_1a = create(:garden, user: @user_1)
      @garden_1b = create(:garden, user: @user_1)
      @garden_1c = create(:garden, user: @user_1)

	    @user_2 = create(:user)	
      @garden_2a = create(:garden, user: @user_2)
      @garden_2b = create(:garden, user: @user_2)

      allow_any_instance_of(ApplicationController).to \
        receive(:current_user).and_return(@user_1)
		end
		
		it "takes me to the gardens index where it shows only my gardens" do
      visit profile_path(@user_1)
      click_link("Gardens")

      expect(page).to have_content("Name: #{@garden_1a.name}")
      expect(page).to have_content("Latitude: #{@garden_1b.latitude}")
      expect(page).to have_content("Longitude: #{@garden_1c.longitude}")
      expect(page).to have_content("Maximum Moisture: #{@garden_1b.max_moisture}")
      expect(page).to have_content("Minimum Moisture: #{@garden_1a.min_moisture}")

      expect(page).to_not have_content(@garden_2a.name)
      expect(page).to_not have_content(@garden_2b.name)
		end
	end
end
