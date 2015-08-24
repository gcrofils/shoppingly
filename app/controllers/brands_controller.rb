class BrandsController < CrudController
  
  layout "application"
  
  def find_entry
    model_scope.friendly.find(params[:id])
  end
    
end
