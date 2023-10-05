class SpacesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_space, only: [:show, :edit, :update]
  before_action :check_lister, only: [:new, :create, :edit, :update]

  def index
    @spaces = Space.all

    if params[:city].present?
      @spaces = @spaces.where(city: params[:city])
    end

    if params[:availability].present?
      @spaces = @spaces.where(availability: true)
    end
  end

  def show
    @space = Space.find(params[:id])
  end

  private

  def set_space
    @space = Space.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = 'Space not found.'
    redirect_to root_path
  end

  def check_lister
    redirect_to root_path, alert: "Only listers can perform this action" unless current_user.lister?
  end
end
