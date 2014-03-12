# == Schema Information
#
# Table name: authorships
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  skill_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Authorship < ActiveRecord::Base
  belongs_to :user
  belongs_to :skill
end
