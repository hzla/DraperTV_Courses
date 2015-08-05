class AddAmaTypeToAmas < ActiveRecord::Migration
  def change
    add_column :amas, :ama_type, :string, default: "monthly"
  end
end
