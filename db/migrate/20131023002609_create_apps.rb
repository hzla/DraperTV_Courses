class CreateApps < ActiveRecord::Migration
  def change
    create_table :apps do |t|
      t.string :first
      t.string :last
      t.string :email
      t.string :phone
      t.text :exist
      t.text :business
      t.string :dob
      t.string :college
      t.string :media
      t.string :gender
      t.string :street_address
      t.string :postal_code
      t.string :state
      t.string :country
      t.string :marketing
      t.string :technical
      t.string :city

      t.timestamps
    end
  end
end
