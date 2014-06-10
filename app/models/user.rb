class User < ActiveRecord::Base
  after_commit :flush_cache
  after_touch :flush_cache
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable

  extend FriendlyId

  friendly_id :full_name, use: [:slugged, :finders]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable, :timeout_in => 3.months

  has_attached_file :avatar,
    :styles => { :medium => "120x120#", :thumb => "40x40#", :large => "220x220#" },
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

  has_many :authorships
  has_many :skills, through: :authorships
  has_many :activity_feeds

  has_many :activities
  has_many :posts

  SORT_FIELDS = { "pcounter" => 'Highest Score', "pcounter desc" => 'Lowest Score', "first_name asc" => 'First Name', "last_name asc" => 'Last Name' }


  def full_name
    [first_name, last_name].join(' ')
  end

  def twitter_link
    ['http://www.twitter.com', twitter].join('/')
  end





def self.cached_find(id)
  Rails.cache.fetch([name, id]) { find(id) }
end

def flush_cache
  Rails.cache.delete([self.class.name, id])
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
