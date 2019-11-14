class GardensController < ApplicationController
  before_action :require_user, only: [:index]

  def index
    @gardens = current_user.gardens
  end
end
