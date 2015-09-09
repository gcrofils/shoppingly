class Picture < Ckeditor::Picture
  alias_attribute :title,         :data_name
  alias_attribute :image,         :data
  alias_attribute :image_width,   :data_width
  alias_attribute :image_height,  :data_height
  alias_attribute :image_size,    :data_size
  
  has_many :posts
  has_many :itineraries
  belongs_to :assetable, :polymorphic => true
  
  def owner=(owner)
    self.assetable_id = owner.id
    self.assetable_type = :User
  end
  
  def owner
    return nil unless assetable_type.eql?('User')
    User.find(assetable_id)
  end
  

end
