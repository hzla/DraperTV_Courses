class CreateCodes < ActiveRecord::Migration
  def change
    create_table :codes do |t|
      t.string :body
      t.boolean :used, default: false
    end
  end
end
