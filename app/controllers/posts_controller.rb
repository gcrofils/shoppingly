class PostsController < ApplicationController
  
  layout "application"
  
  def likes
    @post = Post.find(params[:id])
    render :partial => 'likes', locals: {resource: @post}
  end
  
  def liked
    vote_unvote true
  end
  
  def unliked
    vote_unvote false
  end
  
  def new
    @post = Post.new
    respond_to :js
  end
  
  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      flash[:notice] = "Post updated"
      @posts = current_user.posts
      render 'users/posts'
    else
      flash[:alert] = "error update"
      render 'new'
    end
  end
  
  def show
    #@post = Post.friendly.find(params[:id])
    @post = Post.find(params[:id])
  end
  
  def edit
    @post = Post.find(params[:id])
    respond_to :js
  end
  
  def update
    @post = Post.find(params[:id])
    @post.user = current_user
    respond_to do |format|
      format.js do 
        if @post.update_attributes(post_params)
          flash[:notice] = "Post updated"
          @posts = current_user.posts
          render 'users/posts'
        else
          flash[:alert] = "error update"
          render 'edit'
        end
      end
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    flash[:notice] = (@post.destroy ? 'Post destroy' : "error destroy")
    @posts = current_user.posts
    render 'users/posts'
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :body, :summary, :photo_id)
  end
  
  def vote_unvote(choice=true)
    @post = Post.find(params[:id])
    choice ? current_user.vote_for(@post) : current_user.unvote_for(@post) 
    respond_to do |format|
      format.html { redirect_to stored_location_for(:user) }
      format.js {render 'likes'}
    end
  end
  
end
