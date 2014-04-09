# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  first_name             :string(255)
#  last_name              :string(255)
#  bio                    :text
#  twitter                :string(255)
#  facebook               :string(255)
#  program                :string(255)
#  linkedin               :string(255)
#  street_address         :string(255)
#  city                   :string(255)
#  state                  :string(255)
#  country                :string(255)
#  zip                    :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  avatar_file_name       :string(255)
#  avatar_content_type    :string(255)
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#  online                 :string(255)      default("online")
#  team                   :string(255)
#  skype                  :string(255)
#  gmail                  :string(255)
#  slug                   :string(255)
#  latitude               :float            default(37.5638)
#  longitude              :float            default(-122.325192)
#  employment             :string(255)
#  instagram              :string(255)
#  angellist              :string(255)
#  dribbble               :string(255)
#  github                 :string(255)
#  nCounter               :integer
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable

  extend FriendlyId

  friendly_id :full_name, use: [:slugged, :finders]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :superhero_power, :team, :skype, :gmail, :instagram, :angellist, :dribbble, :github
  attr_accessible :bio, :city, :country, :facebook, :first_name, :last_name, :linkedin, :program, :state, :street_address, :twitter, :zip, :online, :employment
  attr_accessible :avatar, :tag_list, :ncounter, :pcounter
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
  acts_as_voter
  has_surveys
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

  validates :password, presence: true, length: {minimum: 5, maximum: 120}, on: :create
  validates :password, length: {minimum: 5, maximum: 120}, on: :update, allow_blank: true

  after_commit :flush_cache

  SORT_FIELDS = { "pcounter" => 'Highest Score', "pcounter desc" => 'Lowest Score', "first_name asc" => 'First Name', "last_name asc" => 'Last Name' }

  
  
  def self.cached_find(id)
    Rails.cache.fetch([first_name, id], expires_in: 5.minutes) { find(id) }
  end
  
  def flush_cache
    Rails.cache.delete([self.class.first_name, id])
  end


  def full_name
    [first_name, last_name].join(' ')
  end

  def twitter_link
    ['http://www.twitter.com', twitter].join('/')
  end


  # include PgSearch
  # pg_search_scope :search, against: [:first_name, :last_name],
  # using: {tsearch: {dictionary: "english"}},
  # associated_against: {skills: :name}


  # def self.text_search(query)
  #   if query.present?
  #     #where("first_name @@ :q OR last_name @@ :q OR country @@ :q OR (first_name || ' ' || last_name) @@ :q OR online @@ :q OR team @@ :q OR team @@ :q", :q => query)
  #   search(query)
  #   else
  #     scoped
  #   end
  # end
end
