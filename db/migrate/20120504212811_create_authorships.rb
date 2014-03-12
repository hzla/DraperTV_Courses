class CreateAuthorships < ActiveRecord::Migration
  def change
    create_table :authorships do |t|
      t.belongs_to :user
      t.belongs_to :skill

      t.timestamps
    end
    add_index :authorships, :user_id
    add_index :authorships, :skill_id
  end
end