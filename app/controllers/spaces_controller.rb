class SpacesController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  before_action :set_space, only: [:show]

  def index
    @spaces = Space.all
  end

  def new
  end

  def show
  end

  private

  def set_space
    @space = Space.find(params[:id])

    flash[:alert] = 'Space not found'
    redirect_to root_path
  end
end
