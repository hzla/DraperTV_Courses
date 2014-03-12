class AddSpeakersToAssignments < ActiveRecord::Migration
  def change
    add_column :assignments, :speaker_name, :string
    add_column :assignments, :speaker_bio, :text
    add_column :assignments, :speaker_linkedin, :string
    add_column :assignments, :speaker_twitter, :string
    add_column :assignments, :speaker_angel, :string
    add_column :assignments, :category, :string
  end
end
