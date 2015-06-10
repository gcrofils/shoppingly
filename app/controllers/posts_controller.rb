class PostsController < CrudController
  self.permitted_attrs = [:title, :body]
end
