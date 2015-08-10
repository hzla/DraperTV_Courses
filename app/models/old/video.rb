class Video < ActiveRecord::Base

  def should_generate_new_friendly_id?
    new_record?
  end

  attr_accessible :category, :description, :order_id, :preview_url, :slug, :speaker_angel, :speaker_bio, :speaker_linkedin, :speaker_name, :speaker_twitter, :title, :vimeo_url, :speaker_pic, :video_pic
  has_many :user_comments, as: :commentable
  validates_presence_of :slug
  has_attached_file :speaker_pic,
    :styles => { :large => "300x300#" },
    :default_url => "/images/icon_missing.png",
    :bucket => 'duhonline'
  has_attached_file :video_pic,
    :styles => { :large => "300x300#" },
    :default_url => "/images/icon_missing.png",
    :bucket => 'duhonline'
end
