class Skill < ActiveRecord::Base
  attr_accessible :name
  has_many :authorships
  has_many :users, through: :authorships
  attr_accessible :first_name, :user_ids
  has_many :authorships
  has_many :users, through: :authorships
end
