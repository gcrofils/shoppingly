class UsersController < CrudController
  
  layout "application"
   
  def show
    @user = User.find_by_username!(params[:username])
  end
  
  def brands
    if @user = User.find_by_id(params[:id])
      @brands = @user.liked_brands
      render :partial => 'users/liked/brands', locals: {brands: @brands}
    else  
      @user   = current_user
      #@brands = @user.brands
    end
  end
  
  def posts
    if @user = User.find_by_id(params[:id])
      @posts = @user.liked_posts
      render :partial => 'users/liked/posts', locals: {posts: @posts}
    else
      @user   = current_user
      @posts  = @user.posts
    end
  end
  
  def itineraries
    if @user = User.find_by_id(params[:id])
      @itineraries = @user.liked_itineraries
      render :partial => 'users/liked/itineraries', locals: {itineraries: @itineraries}
    else
      @user         = current_user
      @itineraries  = @user.itineraries
    end
  end
  
  def following
    @user = User.find(params[:id])
    @users = @user.following
    render :partial => 'users/liked/users', locals: {users: @users}
  end
  
  def followers
    @user = User.find(params[:id])
    @users = @user.followers
  end
  
  def likes
    resource  = voteable.find(params[:id])
    render :partial => 'likes', locals: {resource: resource}
  end
  
  def liked
    vote_unvote true
  end
  
  def unliked
    vote_unvote false
  end
  
  private
  
  def vote_unvote(choice=true)
    @ressource = voteable.find(params[:id])
    begin
    choice ? current_user.vote_for(@ressource) : current_user.unvote_for(@ressource) 
    rescue
    end
    respond_to do |format|
      format.html { redirect_to stored_location_for(:user) }
      format.js {render 'likes'}
    end
  end
  
  def voteable
    params[:voteable].capitalize.constantize
  end
  
end