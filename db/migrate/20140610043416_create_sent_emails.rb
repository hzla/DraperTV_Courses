class CreateSentEmails < ActiveRecord::Migration
  def change
    create_table :sent_emails do |t|
      t.string :name
      t.string :email
      t.date :sent

      t.timestamps
    end
  end
end
