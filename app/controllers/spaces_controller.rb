class SpacesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  
  def index
    @spaces = Space.all
  end
  def new
  end
end
