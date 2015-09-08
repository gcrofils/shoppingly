class PicturesController < ApplicationController
  
  def index
    per_page = params[:per_page] || 20
    @pictures = Picture.all.paginate(:page => params[:page], :per_page => per_page).decorate
    respond_to do |format|
      format.html { render :layout => false }
      format.js
    end
  end
  
  def create
    picture = Picture.new(picture_params)
    picture.owner = current_user
    picture.save
    redirect_to pictures_path
  end
  
  private 
  
  def picture_params
    params.require(:picture).permit(:data, :data_name)
  end
  
end
