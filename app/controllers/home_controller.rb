class HomeController < ApplicationController
  def show
    @home = Home.new
    #respond_to(:html) if stale?(@home)
  end
end
