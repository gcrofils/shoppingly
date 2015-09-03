class Itinerary < ActiveRecord::Base
  
  belongs_to  :user
  has_many    :stops
  has_many    :establishments, through: :stops
  has_many    :brands, through: :establishments
  has_one     :pin, as: :pinnable
  
  accepts_nested_attributes_for :stops, allow_destroy: true
  
  # multistep build
  cattr_accessor :form_steps do
    %w(intro init map stops user_review)
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
    state :intro do
      event :next_step, :transitions_to => :init
    end
    state :init do
      event :next_step, :transitions_to => :map
      event :prev_step, :transitions_to => :intro
    end
    state :map do
      event :next_step, :transitions_to => :stops
      event :prev_step, :transitions_to => :init
    end
    state :stops do
      event :next_step, :transitions_to => :user_review
      event :prev_step, :transitions_to => :map
    end
    state :user_review do
      event :submit_to_editor, :transitions_to => :awaiting_editor_review
      event :prev_step, :transitions_to => :stops
    end
    state :awaiting_editor_review do
      event :review, :transitions_to => :being_reviewed
    end
    state :being_reviewed do
      event :review, :transitions_to => :being_reviewed
      event :accept, :transitions_to => :accepted
      event :reject, :transitions_to => :rejected
    end
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
  
  def submit_to_editor
    puts 'sending email to editor : a new itinerary is waiting'
    puts 'sending email to contributor : your itinerary has been submitted'
  end
  
  def review(reviewer = nil)
    if awaiting_editor_review?
      puts "sending email to contributor: your itinerary #{title} is being reviewed by #{reviewer.try(:username)}"
    end
  end
  
  def accept
    puts "sending email to contributor:your itinerary #{title} has been accepted"
    pin_it!
  end
  
  def reject
    puts "sending email to contributor: your itinerary #{title} has been rejected"
  end
  
  def pin_it!
    Pin.create(pinnable: self, keywords: description)
  end
  
  def required_for_step?(step)
    # All fields are required if no form step is present
    return true if form_step.nil?
    # All fields from previous steps are required if the
    # step parameter appears before or we are on the current step
    return true if self.form_steps.index(step.to_s) <= self.form_steps.index(form_step)
  end
  
end
