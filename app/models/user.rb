class User < ActiveRecord::Base
  after_commit :flush_cache
  after_touch :flush_cache
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable, :timeout_in => 3.months
  has_attached_file :avatar,
    :styles => { :medium => "120x120#", :thumb => "40x40#", :large => "220x220#" },
    :default_url => '/assets/avatars/missing.png',
    :bucket => 'duhonline',
    :storage => :s3,
    :s3_credentials => "#{Rails.root}/config/s3.yml"
  validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/png', 'image/svg+xml']
  validates_attachment_size :avatar, :less_than => 10.megabytes
  has_many :events
  acts_as_taggable
  # acts_as_voter
  has_surveys
  validates :email, presence: true, uniqueness: {message: "email has already been taken"}

  validates :password, presence: {message: "you must fill out a password"}, on: :create
  validates :password, presence: true, on: :update, allow_blank: true

  has_many :authorizations
  has_many :comments
  has_many :progresses
  attr_accessible :full_name, :username, :show_topic_tutorial, :show_track_tutorial, :karma, :paid, :email, :password, :password_confirmation, :customer_id, :plan, :role, :color, :first_name, :last_name, :avatar, :profile_pic_url
  after_create :assign_color
  validates_uniqueness_of :username


  def self.create_with_facebook auth_hash
    timezone = auth_hash.extra.raw_info.timezone
    profile = auth_hash['info']
    fb_token = auth_hash.credentials.token
    user = User.new email: profile["email"], full_name: profile["name"], timezone: timezone, password: rand(1213920) + 1000000, profile_pic_url: profile["image"]
    user.authorizations.build :uid => auth_hash["uid"]
    user if user.save(validate: false)
  end

  def avatar_pic
    if !avatar.blank? 
      avatar.url
    elsif profile_pic_url
      profile_pic_url
    else
      avatar.url
    end
  end

  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end

  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end

  def tier
    return "Admin" if role == "admin"
    if karma >= 4000
      "Guru" 
    elsif karma >= 3000
      "Legend"
    elsif karma >= 2300
      "Champion"
    elsif karma >= 1700
      "Hero"
    elsif karma >= 1200
      "Challenger"
    elsif karma >= 700
      "Rookie"
    elsif karma >= 10
      "Trainee"
    else karma >= 0
      "Recruit"
    end
  end

  def update_title_and_karma direction
    update_attribute 'karma', karma + direction
    update_attribute 'title', tier
  end

  def plan_color
    colors = {"Hero" => "green", "SuperHero" => "blue", "SuperHeroYearly" => "red"}
    colors[plan]
  end

  def randomize_color
    update_attributes color: "#" + ('%06x' % (rand * 0xffffff))
  end

  def should_ask_for_info
    created_at < "2015-08-30 00:00:00"
  end

  private

  def assign_color
    update_attributes color: "#" + ('%06x' % (rand * 0xffffff))
  end
end
