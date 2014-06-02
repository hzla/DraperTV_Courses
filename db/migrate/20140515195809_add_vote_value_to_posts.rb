class AddVoteValueToPosts < ActiveRecord::Migration
	def change
     change_column :posts, :vote, :integer, :default => 0
	end
end
