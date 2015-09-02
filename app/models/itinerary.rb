class Itinerary < ActiveRecord::Base
  
  belongs_to  :user
  has_many    :stops
  has_many    :establishments, through: :stops
  has_many    :brands, through: :establishments
  has_one     :pin, as: :pinnable
  
  accepts_nested_attributes_for :stops, allow_destroy: true
  
  # multistep build
  cattr_accessor :form_steps do
    %w(intro init map stops)
  end  
  attr_accessor :form_step
  
  # validations
  validates :user, :presence => true, if: -> { required_for_step?(:intro) }
  
  with_options if: -> { required_for_step?(:init) } do |step|
    step.validates :title, presence: true
    step.validates :description, presence: true
  end

  # thumbs_up
  acts_as_voteable
  
  # workflow
  include Workflow
  workflow_column :status
  workflow do
    state :intro
    state :init
    state :map
    state :stops
    state :awaiting_review
    state :being_reviewed
    state :accepted
    state :rejected
  end
  
  # initial data migration
  def download_images
    begin
      
      self.description = description.gsub(/\{\{([a-zA-Z0-9\/\.\&\:\=\?\_]*)\}\}/x) do |match| 
        image = Dragonfly.app.fetch_url($1)
        photo = Ckeditor::Asset.new(data: image, assetable_type: 'User', assetable_id: user.id, type: "Ckeditor::Picture")
        photo.data_name = title
        photo.save
        ActionController::Base.helpers.image_tag(photo.data.url, class:'img-responsive img-thumbnail', alt: title)
      end
      
      self.save
    rescue Exception => e
      puts "#{title} has not been updated"
      puts e.message
    end
  end
  
  private
  
  def required_for_step?(step)
    # All fields are required if no form step is present
    return true if form_step.nil?
    # All fields from previous steps are required if the
    # step parameter appears before or we are on the current step
    return true if self.form_steps.index(step.to_s) <= self.form_steps.index(form_step)
  end
  
end
