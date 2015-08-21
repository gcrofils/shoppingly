class PinsController < ApplicationController
  
  def index
    page = (params[:page] || 1).to_i
    @pins = Pin.limit(3).offset(3 * (page - 1) )
    #@posts = Post.all.sample(3)
  end
  
end
