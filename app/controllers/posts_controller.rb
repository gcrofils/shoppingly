class PostsController < CrudController
  
  layout "application"
  
  self.permitted_attrs = [:title, :body]
  
  def waterfall
    page = (params[:page] || 1).to_i
    @posts = Post.limit(3).offset(3 * (page - 1) )
    #@posts = Post.all.sample(3)
  end
  
  def likes
    @post = Post.find(params[:id])
    render :partial => 'likes', locals: {post: @post}
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
