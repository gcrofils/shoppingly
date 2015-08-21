class Pin < ActiveRecord::Base
  belongs_to :pinnable, polymorphic: true
  default_scope { order('updated_at DESC') }
end
