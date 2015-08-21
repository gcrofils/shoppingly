class PostsController < CrudController
  
  layout "application"
  
  self.permitted_attrs = [:title, :body]
  
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
  
  private
  
  def vote_unvote(choice=true)
    @post = Post.find(params[:id])
    choice ? current_user.vote_for(@post) : current_user.unvote_for(@post) 
    respond_to do |format|
      format.html { redirect_to stored_location_for(:user) }
      format.js {render 'likes'}
    end
    
  end
  
end
