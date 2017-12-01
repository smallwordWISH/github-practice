class Admin::RestaurantsController < ApplicationController
	before_action :authenticate_user!  # 這個是 devise 提供的方法，先檢查必須登入
	before_action :authenticate_admin # 再檢查是否有權限
	before_action :set_restaurant, :only => [:show, :edit, :update, :destroy]

	def index
		@restaurants = Restaurant.all
 	end

 	def new
		@restaurant = Restaurant.new
	end

	def create
		@restaurant = Restaurant.new(restaurant_params)
		if @restaurant.save
			redirect_to admin_restaurants_path
			flash[:notice] = "restaurant was successfully created"
    else
			render :new
			flash[:notice] = "restaurant was failed to created"
    end
	end

  def edit
  end

  def update
		if @restaurant.update(restaurant_params)
			redirect_to admin_restaurant_path(@restaurant)
			flash[:notice] = "restaurant was successfully updated"
		else
			render :edit
			flash[:notice] = "restaurant was failed to update"
		end
  end

  def show
  end

	def destroy
		@restaurant.destroy
		redirect_to admin_restaurants_path
	end

  private

	def set_restaurant
		@restaurant = Restaurant.find(params[:id])
	end

  def restaurant_params
    params.require(:restaurant).permit(:name, :opening_hours, :tel, :address,
    																	:description, :image, :category_id)
  end
end
