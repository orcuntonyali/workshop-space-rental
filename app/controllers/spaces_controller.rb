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
      photos = ["https://res.cloudinary.com/dw4vy98yd/image/upload/v1696419179/Workshop/1.avif",
                "https://res.cloudinary.com/dw4vy98yd/image/upload/v1696419179/Workshop/2.avif",
                "https://res.cloudinary.com/dw4vy98yd/image/upload/v1696597444/23_jzhrkd.avif",
                "https://res.cloudinary.com/dw4vy98yd/image/upload/v1696419178/Workshop/4.avif",
                "https://res.cloudinary.com/dw4vy98yd/image/upload/v1696419178/Workshop/5.avif",
                "https://res.cloudinary.com/dw4vy98yd/image/upload/v1696419174/Workshop/17.avif",
                "https://res.cloudinary.com/dw4vy98yd/image/upload/v1696419173/Workshop/19.avif",
                "https://res.cloudinary.com/dw4vy98yd/image/upload/v1696419176/Workshop/10.avif",
                "https://res.cloudinary.com/dw4vy98yd/image/upload/v1696419175/Workshop/12.avif",
                "https://res.cloudinary.com/dw4vy98yd/image/upload/v1696419175/Workshop/14.avif",
                "https://res.cloudinary.com/dw4vy98yd/image/upload/v1696419175/Workshop/15.avif",
                "https://res.cloudinary.com/dw4vy98yd/image/upload/v1696597443/21_lwm8h9.avif",
                "https://res.cloudinary.com/dw4vy98yd/image/upload/v1696597442/20_mnubg8.avif",
                "https://res.cloudinary.com/dw4vy98yd/image/upload/v1696597443/22_bghtuh.avif"]
      render partial: "spaces_list", locals: { spaces: @spaces, photos: }
    else
      respond_to do |format|
        format.html
        format.js { render partial: "spaces_list", locals: { spaces: @spaces } }
      end
    end
    # rubocop:enable Metrics/MethodLength
  end
end
