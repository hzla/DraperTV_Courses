# == Schema Information
#
# Table name: skills
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Skill < ActiveRecord::Base
  attr_accessible :name
  has_many :authorships
  has_many :users, through: :authorships

  attr_accessible :first_name, :user_ids
  has_many :authorships
  has_many :users, through: :authorships
  
end
