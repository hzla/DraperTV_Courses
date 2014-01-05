class AddRequireUploadToAssignments < ActiveRecord::Migration
  def change
  	add_column :assignments, :require_upload, :boolean, :default => false
  end
end
