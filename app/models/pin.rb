class Pin < ActiveRecord::Base
  belongs_to :pinnable, polymorphic: true
  default_scope { order('updated_at DESC') }
  
  def self.types
    Pin.uniq.pluck(:pinnable_type)
  end
  
end
