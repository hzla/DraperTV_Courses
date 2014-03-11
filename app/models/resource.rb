# == Schema Information
#
# Table name: resources
#
#  id                 :integer          not null, primary key
#  title              :string(255)
#  url                :string(255)
#  description        :text
#  category           :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#

class Resource < ActiveRecord::Base
  attr_accessible :category, :description, :title, :url, :image
  has_attached_file :image, 
    :styles => { :large => "160x160#" }, 
    :bucket => 'duhonline'
end
