class PostsController < CrudController
  
  layout "application"
  
  self.permitted_attrs = [:title, :body]
  
  def waterfall
    puts I18n.locale
    page = (params[:page] || 1).to_i
    @posts = Post.limit(3).offset(3 * (page - 1) )
    #@posts = Post.all.sample(3)
  end
  
end
