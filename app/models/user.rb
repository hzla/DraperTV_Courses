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
  validates :email, presence: true,
  					uniqueness: true

  has_many :authorships
  has_many :authorizations
  has_many :skills, through: :authorships
  has_many :activity_feeds

  has_many :activities
  has_many :posts
  has_many :comments
  has_many :progresses

  SORT_FIELDS = { "pcounter" => 'Highest Score', "pcounter desc" => 'Lowest Score', "first_name asc" => 'First Name', "last_name asc" => 'Last Name' }


  def self.create_with_facebook auth_hash
    timezone = auth_hash.extra.raw_info.timezone
    profile = auth_hash['info']
    fb_token = auth_hash.credentials.token
    user = User.new first_name: profile["name"].split(" ")[0], last_name: profile["name"].split(" ")[-1], timezone: timezone, email: profile["email"], password: rand(1213920) + 1000000
    user.authorizations.build :uid => auth_hash["uid"]
    user if user.save(validate: false)
  end

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

  def tier
    karma = comments.map {|c| c.get_upvotes.size }.inject(:+)
    case karma
    when karma >= 4000
      "Guru"
    when karma >= 3000
      "Legend"
    when karma >= 2300
      "Champion"
    when karma >= 1700
      "Hero"
    when karma >= 1200
      "Challenger"
    when karma >= 700
      "Rookie"
    when karma >= 300
      "Trainee"
    else karma >= 0
      "Recruit"
    end
  end

  def update_title
    update_attributes title: tier
  end
end
