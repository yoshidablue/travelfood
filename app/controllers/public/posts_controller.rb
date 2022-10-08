class Public::PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def create
    @post = current_customer.posts.new(post_params)
    @post.customer_id = current_customer.id
    if @post.save
      redirect_to posts_path(@post)
    else
      render :new
    end
  end

  def index
    @posts = Post.all.order("created_at DESC")
  end

  def show
    @post = Post.find(params[:id])
    @food_comment = FoodComment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:food_name, :introduction, :prefecture_id, :comment, :image)
  end

end