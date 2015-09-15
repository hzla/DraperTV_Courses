class Topic < ActiveRecord::Base
  has_many :tracks

  extend FriendlyId
  friendly_id :name, use: :slugged
  
  extend Extensions::ProgressFinder
  include Extensions::Progressable
  include Extensions::Namable
  include Extensions::Iconable
end
