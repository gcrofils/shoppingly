class PostsController < CrudController
  
  layout "application"
  
  self.permitted_attrs = [:title, :body]
  
  def waterfall
    puts I18n.locale
    page = (params[:page] || 1).to_i
    @posts = Post.limit(3).offset(3 * (page - 1) )
    #@posts = Post.all.sample(3)
  end
  
  def likes
    @post = Post.find(params[:id])
    render :layout => false
  end
  
  def liked
    @post = Post.find(params[:id])
    current_user.vote_for(@post)
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js {render 'likes'}
    end
    
  end
  
  def unliked
    @post = Post.find(params[:id])
    current_user.unvote_for(@post)
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js {render 'likes'}
    end
  end
  
end
