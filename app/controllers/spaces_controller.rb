class SpacesController < ApplicationController
  before_action :set_space, only: [:show]

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
