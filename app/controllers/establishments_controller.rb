class EstablishmentsController < ApplicationController
  
  def create
    @brand = Brand.find(params[:brand_id])
    @establishment = @brand.establishments.new(establishment_params)
    if @establishment.save
      flash[:notice] = "Establishment created"
      redirect_to stored_location_for(:user)
    else
      @dont_store_location = true
      flash[:alert] = "error create"
      render 'brands/show'
    end
    
  end
  
  def destroy
    @establishment = Establishment.find(params[:id])
    if @establishment.destroy
      flash[:notice] = "Establishment destroyed"
      redirect_to stored_location_for(:user)
    else
      flash[:alert] = "error"
      redirect_to stored_location_for(:user)
    end
  end
  
  def edit
    @establishment = Establishment.find(params[:id])
    @brand = @establishment.brand
    @dont_store_location = true
    render :layout => false
  end
  
  def update
    @establishment = Establishment.find(params[:id])
    @brand = @establishment.brand 
    if @establishment.update_attributes(establishment_params)
      flash[:notice] = "Establishment updated"
      redirect_to stored_location_for(:user)
    else
      @dont_store_location = true
      flash[:alert] = "error update"
      render 'brands/show'
    end
  end
  
  private

  def establishment_params
    params.require(:establishment).permit(:brand_id, :label, :address)
  end
  
end