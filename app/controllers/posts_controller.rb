class PostsController < CrudController
  self.permitted_attrs = [:title, :body]
  
  def waterfall
    page = (params[:page] || 1).to_i
    @posts = Post.limit(10).offset( 10 * (page - 1) )
  end
  
end
