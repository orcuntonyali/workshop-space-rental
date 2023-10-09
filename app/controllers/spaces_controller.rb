class SpacesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_space, only: %i[show edit update]
  before_action :check_lister, only: %i[new create edit update]

  def index
    @spaces = Space.all
    @spaces = search(params[:query]) if params[:query].present?

    if params[:select_date].present?
      @spaces = @spaces.select { |space| space.available?(Date.parse(params[:select_date])) }
    end
    setting_image
  end

  def show
    @space = Space.find(params[:id])
    @selected_date = params[:selected]
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
    params.require(:space).permit(:title, :description, :facilities, :equipment, :capacity, :availability, :price,
                                  images: [])
  end

  def search(query)
    Space.search_by_city_and_title(query)
  end

  # rubocop:disable Metrics/MethodLength
  # Ignoring metric length due to length of photos...
  def setting_image
    if request.xhr?
      render partial: "spaces_list", locals: { spaces: @spaces }
    else
      respond_to do |format|
        format.html
        format.js { render partial: "spaces_list", locals: { spaces: @spaces } }
      end
    end
    # rubocop:enable Metrics/MethodLength
  end
end
