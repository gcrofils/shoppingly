class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable
         
  validates :username, :presence => true, :uniqueness => { :case_sensitive => false }
         
  dragonfly_accessor :avatar
  
  has_many :posts
  has_many :itineraries
  has_many :pictures, :as => :assetable
  
  # thumbs_up
  acts_as_voter
  acts_as_voteable
  
  def liked_brands
    Brand.tally.where('votes.voter_id' => id).where('voter_type = ?', 'User').where('voteable_type = ?', 'Brand')
  end
  
  def liked_posts
    Post.tally.where('votes.voter_id' => id).where('voter_type = ?', 'User').where('voteable_type = ?', 'Post')
  end
  
  def liked_itineraries
    Itinerary.tally.where('votes.voter_id' => id).where('voter_type = ?', 'User').where('voteable_type = ?', 'Itinerary')
  end
  
  def following
    User.tally.where('votes.voter_id' => id).where('voter_type = ?', 'User').where('voteable_type = ?', 'User')
  end
  
  def followers
    User.tally.where('votes.voteable_id' => id).where('voter_type = ?', 'User').where('voteable_type = ?', 'User')
  end
  
  def to_param
    username
  end
  
  # Virtual attribute for authenticating by either username or email
  # This is in addition to the real persisted field 'username'
  #attr_accessor :login
  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end
  
  # https://github.com/plataformatec/devise/wiki/How-To:-Allow-users-to-sign-in-using-their-username-or-email-address
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      conditions[:email].downcase! if conditions[:email]
      where(conditions.to_hash).first
    end
  end
    
end
