# == Schema Information
#
# Table name: apps
#
#  id                 :integer          not null, primary key
#  first              :string(255)
#  last               :string(255)
#  email              :string(255)
#  phone              :string(255)
#  exist              :text
#  business           :text
#  dob                :string(255)
#  college            :string(255)
#  media              :string(255)
#  gender             :string(255)
#  street_address     :string(255)
#  postal_code        :string(255)
#  state              :string(255)
#  country            :string(255)
#  marketing          :string(255)
#  technical          :string(255)
#  city               :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#

class App < ActiveRecord::Base
  attr_accessible :first, :last, :email, :phone, :exist, :business, :dob, :college, :media, :gender, :street_address, :postal_code, :state, :country, :martketing, :technical, :city, :marketing, :photo, :response, :status, :payment, :notes
  validates_presence_of :first
  has_attached_file :photo, 
    :styles => { :large => "300x300#" }, 
    :bucket => 'duhonline',
    :storage => :s3,
    :s3_credentials => "#{Rails.root}/config/s3.yml"
end
