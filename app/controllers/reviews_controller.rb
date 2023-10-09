class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_booker, only: %i[new create]

  private

  def check_booker
    redirect_to root_path, alert: "Only bookers can perform this action" unless current_user.booker?
  end
end
