class BrandsController < CrudController
  before_filter :authenticate_user!
  layout "application"
end
