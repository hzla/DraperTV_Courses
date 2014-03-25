class AddEventReminderToUser < ActiveRecord::Migration
  def change
    add_column :users, :eventReminder, :boolean, default: false
  end
end
