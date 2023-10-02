class SpacesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_space, only: [:show, :edit, :update]

  def index
    @spaces = current_user&.lister? ? current_user.spaces : Space.all
  end

  def new
    @space = current_user.spaces.build
  end

  def show
  end

  def create
    @space = current_user.spaces.build(space_params)
    if @space.save
      redirect_to spaces_path, notice: 'Space was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @space.update(space_params)
      redirect_to spaces_path, notice: 'Space was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_space
    @space = Space.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = 'Space not found.'
    redirect_to root_path
  end

  def space_params
    params.require(:space).permit(:title, :description, :facilities, :equipment, :capacity, :availability, :price, images: [])
  end

  def search
    @spaces = SpaceSearch.new(params).search
    render :index
  end
end