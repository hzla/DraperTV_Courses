class CreateMilestones < ActiveRecord::Migration
  def change
    create_table :milestones do |t|
      t.text :vision
      t.text :creativity
      t.text :speedstrength
      t.text :evangelism
      t.text :power
      t.text :survival
      t.text :brilliance

      t.timestamps
    end
  end
end
