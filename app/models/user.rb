class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable, :timeout_in => 3.months

  has_many :authorizations
  has_many :comments
  has_many :progresses
  has_attached_file :avatar,
    :styles => { :medium => "120x120#", :thumb => "40x40#", :large => "220x220#" },
    :default_url => '/assets/avatars/missing.png',
    :bucket => 'duhonline',
    :storage => :s3,
    :s3_credentials => "#{Rails.root}/config/s3.yml"
  
  validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/png', 'image/svg+xml']
  validates_attachment_size :avatar, :less_than => 10.megabytes
  validates :email, presence: true, uniqueness: {message: "email has already been taken"}
  validates :password, presence: {message: "you must fill out a password"}, on: :create
  validates :password, presence: true, on: :update, allow_blank: true
  validates_uniqueness_of :username, :allow_nil => true

  after_create :assign_color
  
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

  def complete lesson
    finished_lessons = ((finished_lesson_ids || []) << lesson.id).uniq.sort
    update_attributes(finished_lesson_ids: finished_lessons)
    track = lesson.track
    added_karma = 5
    if track.completed? self
      added_karma += 10
    end
    if track.topic.completed? self
      added_karma += 20
    end
    update_title_and_karma added_karma
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

  def plan
    super.nil? ? "Trial" : super
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
