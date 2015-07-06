class ChangeModuleIdInLessons < ActiveRecord::Migration
  def change
  	rename_column :lessons, :mod_id, :track_id
  end
end
