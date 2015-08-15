class UsersController < CrudController
  
  layout "application"
   
  def show
    @user = User.find_by_username!(params[:username])
  end
  
  def brands
    @user = User.find(params[:id])
    @brands = @user.brands
    render :partial => 'users/liked/brands', locals: {brands: @brands}
  end
  
  def posts
    @user = User.find(params[:id])
    @posts = @user.posts
    render :partial => 'users/liked/posts', locals: {posts: @posts}
  end
  
  def itineraries
    @user = User.find(params[:id])
    @itineraries = @user.itineraries
    render :partial => 'users/liked/itineraries', locals: {itineraries: @itineraries}
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
    choice ? current_user.vote_for(@ressource) : current_user.unvote_for(@ressource) 
    respond_to do |format|
      format.html { redirect_to stored_location_for(:user) }
      format.js {render 'likes'}
    end
  end
  
  def voteable
    params[:voteable].capitalize.constantize
  end
  
end