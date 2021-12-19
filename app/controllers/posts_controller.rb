class PostsController < ApplicationController
  
  def index
    @posts = Post.where(user_id: [current_user.id, *current_user.following_ids])
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save!(post_params)
       redirect_to post_path(@post)
    else
       render 'new'
    end
  end
  
  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @user = @post.user
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    @post.user_id = current_user.id
    if @post.update(post_params)
       redirect_to post_path
    else
      render 'edit'
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.user_id = current_user.id
    @post.destroy
    redirect_to posts_path
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :body, :genre, :rate)
  end
  
end
