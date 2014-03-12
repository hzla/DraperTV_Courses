# == Schema Information
#
# Table name: posts
#
#  id                :integer          not null, primary key
#  content           :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  file_file_name    :string(255)
#  file_content_type :string(255)
#  file_file_size    :integer
#  file_updated_at   :datetime
#  user_id           :integer
#

class Post < ActiveRecord::Base
  after_commit :flush_cache

  attr_accessible :content, :user_id
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
