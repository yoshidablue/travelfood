class Public::CustomersController < ApplicationController

  def index
    @customers = Customer.all.order("created_at DESC")
  end

  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts.order("created_at DESC")
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to customer_path
    else
      render :edit
    end
  end

  def unsubscribe
    @customer = current_customer
  end

  def withdraw
    @customer = current_customer
    @customer.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  def favorites
    @customer = Customer.find(params[:id])
    favorites = Favorite.where(customer_id: @customer.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
  end

  private

  def customer_params
    params.require(:customer).permit(:profile_image, :name, :prefecture_id, :food)
  end

end