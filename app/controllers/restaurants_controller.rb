class RestaurantsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :top, :chef]
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy, :chef]

  # '/restaurants/top'
  def top
    @restaurants = Restaurant.where(rating: 5)
  end

  # '/restaurants/52/chef'
  def chef
    @chef = @restaurant.chef_name
  end

  # '/restaurants'
  def index
    @restaurants = Restaurant.all
    # array of all of our lat lng
    @markers = @restaurants.geocoded.map do |restaurant|
      {
        lat: restaurant.latitude,
        lng: restaurant.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: {restaurant: restaurant}),
        marker_html: render_to_string(partial: "marker")
      }
    end
  end

  # '/restaurants/1'
  def show
    @review = Review.new
    @markers = [
      {
        lat: @restaurant.latitude,
        lng: @restaurant.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: {restaurant: @restaurant}),
        marker_html: render_to_string(partial: "marker")
      }
    ]
  end

  # '/restaurants/new'
  def new
    # just for the form
    @restaurant = Restaurant.new
  end

  # we cant get here by a link. we have to submit the form
  # no view for this, this redirects to another page
  def create
    # create an instance of a restaurant
    # try to save it
    # if it saves... go to the show page
    # if it doesnt save... show the form again
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.user = current_user
    if @restaurant.save
      # make a seperate request to go to the show page
      redirect_to restaurant_path(@restaurant)
    else
      # show the new.html.erb (but with the @restaurant we just tried to create)
      render 'new', status: :unprocessable_entity # 422
    end
  end

  # '/restaurants/1/edit'
  def edit
    # just for the form
  end

  # we cant get here by a link. we have to submit the form
  # no view for this, this redirects to another page
  def update
    if @restaurant.update(restaurant_params)
      redirect_to restaurant_path(@restaurant)
    else
      # show the edit.html.erb (but with the @restaurant we just tried to update)
      render 'edit', status: :unprocessable_entity # 422
    end
  end

  def destroy
    @restaurant.destroy
    redirect_to restaurants_path, status: :see_other # redirect
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end
  # strong params
  def restaurant_params
    # whitelists the attributes a user can give in the form (for security)
    params.require(:restaurant).permit(:name, :address, :rating)
  end
end
