class Post < ActiveRecord::Base
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


  
end
