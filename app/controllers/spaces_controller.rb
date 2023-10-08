class SpacesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_space, only: [:show, :edit, :update]
  before_action :check_lister, only: [:new, :create, :edit, :update]

  def index
    @spaces = Space.all

    if params[:query].present?
      @spaces = search(params[:query])
    end

    if params[:select_date].present?
      @spaces = @spaces.select { |space| space.available?(Date.parse(params[:select_date])) }
    end

    if request.xhr?
      render partial: "spaces_list", locals: { spaces: @spaces }
    else
      respond_to do |format|
        format.html
        format.js { render partial: "spaces_list", locals: { spaces: @spaces } }
      end
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

  def space_params
    params.require(:space).permit(:title, :description, :facilities, :equipment, :capacity, :availability, :price, images: [])
  end

  def search(query)
    Space.search_by_city_and_title(query)
  end
end
