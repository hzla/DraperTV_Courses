class AddDatesToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :start_date, :datetime
    add_column :courses, :end_date, :datetime
    add_column :courses, :length, :integer
    add_column :courses, :intro_vimeo, :string
  end
end
