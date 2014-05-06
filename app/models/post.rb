class Post < ActiveRecord::Base

  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  attr_accessible :content, :user_id, :title, :category
  attr_accessible :file
  has_attached_file :file,
				    :styles => { :medium => "120x120#", :preview => "408x308#" },
				    :bucket => 'duhonline',
				    :storage => :s3,
				    :s3_credentials => "#{Rails.root}/config/s3.yml",
            :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :file, :content_type => ['image/jpeg', 'image/png']
  validates_attachment_size :file, :less_than => 10.megabytes
  belongs_to :user
  has_many :user_comments, as: :commentable
  acts_as_voteable

  scope :order_by_upvote, joins("LEFT OUTER JOIN votes ON posts.id = votes.voteable_id AND votes.voteable_type = 'Post'").
                   group('posts.id').
                   order('SUM(CASE vote WHEN true THEN 1 WHEN false THEN -1 ELSE 0 END) DESC')



  def should_generate_new_friendly_id?
    new_record?
  end



end
