class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable

  extend FriendlyId
  friendly_id :full_name, use: :slugged

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :superhero_power, :team, :skype, :gmail, :instagram, :angellist, :dribbble, :github
  attr_accessible :bio, :city, :country, :facebook, :first_name, :last_name, :linkedin, :program, :state, :street_address, :twitter, :zip, :online, :employment
  attr_accessible :avatar, :tag_list
  attr_accessible :latitude, :longitude
  has_attached_file :avatar, 
    :styles => { :medium => "120x120#", :thumb => "40x40#" }, 
    :default_url => '/assets/avatars/missing.png',
    :bucket => 'duhonline',
    :storage => :s3,
    :s3_credentials => "#{Rails.root}/config/s3.yml"
  validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/png']
  validates_attachment_size :avatar, :less_than => 10.megabytes
  has_one :bucketlist
  has_many :bucketlist_items
  has_many :user_assignments
  has_many :badges
  has_many :events
  acts_as_taggable
  has_surveys
  geocoded_by :city
  after_validation :geocode
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true,
  					uniqueness: true

  attr_accessible :name, :skill_ids
  has_many :authorships
  has_many :skills, through: :authorships
  
  has_many :activities
  has_many :posts
  has_many :messages




  def full_name
    [first_name, last_name].join(' ')
  end

  def twitter_link
    ['http://www.twitter.com', twitter].join('/')
  end


  include PgSearch
  pg_search_scope :search, against: [:first_name, :last_name],
  using: {tsearch: {dictionary: "english"}},
  associated_against: {skills: :name}


  def self.text_search(query)
    if query.present?
      #where("first_name @@ :q OR last_name @@ :q OR country @@ :q OR (first_name || ' ' || last_name) @@ :q OR online @@ :q OR team @@ :q OR team @@ :q", :q => query)
    search(query)
    else
      scoped
    end
  end
end