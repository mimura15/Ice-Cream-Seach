class Public::PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @shop = @post.shop
  end

  def new
    @post = Post.new
    @shops = Shop.all
  end

  def create
    post = current_user.posts.build(post_params)
    if post.save
      redirect_to post_path(post)
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    @shops = Shop.all
  end

  def update
    @post = Post.find(params[:id])
    if params[:post][:image_ids]
      params[:post][:image_ids].each do |image_id|
        image = @post.images.find(image_id)
        image.purge
      end
    end
    if @post.update(post_params)
      redirect_to post_path(@post.id)
    else
      @shops = Shop.all
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
    params.require(:post).permit(:title, :content, :shop_id, images: [])
  end

end
