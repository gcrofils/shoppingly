Ckeditor::PicturesController.class_eval do
  
  def index
    per_page = params[:per_page] || 20
    @pictures = Ckeditor.picture_adapter.find_all.paginate(:page => params[:page], :per_page => per_page).decorate
    @picture = Ckeditor.picture_model.new
    respond_to do |format|
      format.html { render :layout => false }
      format.js
    end
  end
  
end