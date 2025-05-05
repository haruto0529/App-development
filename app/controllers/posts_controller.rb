class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy]

  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post, notice: "投稿が成功しました！"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path, notice: '投稿を削除しました'
  end

  private

  def post_params
    params.require(:post).permit(:title, :image_url, :image_introduce, :category)
  end
end
