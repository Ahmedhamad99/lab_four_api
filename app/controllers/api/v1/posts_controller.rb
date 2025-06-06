class Api::V1::PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy]

  def index
    posts = Post.all
    render json: posts
  end

  def show
    render json: @post
  end

  def create
    post = Post.new(post_params)
    if post.save
      render json: post, status: :created
    else
      render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    head :no_content
  end

  private

  def set_post
    @post = Post.find_by(id: params[:id])
    render json: { error: 'Post not found' }, status: :not_found unless @post
  end

  def post_params
    params.require(:post).permit(:title, :body, :user_id)
  end
end
