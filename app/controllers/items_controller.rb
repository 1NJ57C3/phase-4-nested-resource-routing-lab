class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_error

  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      items = user.items
    else
      items = Item.all
    end
    render json: items, include: :user
  end

  def show
    item = Item.find(params[:id])
    render json: item, include: :user
  end

  def create
    item = User.find(params[:user_id]).items.create!(item_params)
    render json: item, status: :created
  end

  private

  def item_params
    params.permit(:name, :description, :price, :user)
  end
  
  def not_found_error errormsg
    render json: { error: errormsg }, status: :not_found
  end

end
