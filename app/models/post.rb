class Post < ActiveRecord::Base
  after_commit :flush_cache

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

  scope :by_score, joins("LEFT OUTER JOIN votes ON posts.id = votes.voteable_id AND votes.voteable_type = 'Post'").
                   group('posts.id').
                   order('SUM(CASE user_votes.vote WHEN true THEN 1 WHEN false THEN -1 ELSE 0 END) DESC')


  def plusminus
    
  end

  def cached_user
    User.cached_find(author_id)
  end

  def self.cached_find(id)
    Rails.cache.fetch([first_name, id]) { find(id) }
  end
  
  def flush_cache
    Rails.cache.delete([self.class.first_name, id])
  end

end
