class UsersController < CrudController
  
  layout "application"
  
  def show
    @user = User.find_by_username!(params[:username])
  end
  
end