class Resource < ActiveRecord::Base
  attr_accessible :category, :description, :title, :url, :image
  has_attached_file :image,
    :styles => { :large => "160x160#" }, 
    :bucket => 'duhonline'
end
