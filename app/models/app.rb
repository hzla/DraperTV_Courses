class App < ActiveRecord::Base
  attr_accessible :first, :last, :email, :phone, :exist, :business, :dob, :college, :media, :gender, :street_address, :postal_code, :state, :country, :martketing, :technical, :city, :marketing, :photo
  validates_presence_of :first
  has_attached_file :photo, 
    :styles => { :large => "300x300#" }, 
    :bucket => 'duhonline',
    :storage => :s3,
    :s3_credentials => "#{Rails.root}/config/s3.yml"
end
