class PostsController < CrudController
  
  layout "application"
  
  self.permitted_attrs = [:title, :body]
  
  def waterfall
    puts I18n.locale
    page = (params[:page] || 1).to_i
    @posts = Post.limit(5).offset( 5 * (page - 1) )
  end
  
end
