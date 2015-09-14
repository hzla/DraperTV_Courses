describe Comment do 
	before :each do 
		@user = create :user
		@comment = create :comment, user_id: @user.id
		@comment.stubs(:user).returns @user
	end

	describe 'comment#self_upvote' do 
		it "increases the comment's user's karma by 1" do
			@comment.self_upvote
			expect(@user.karma).to eq 1
		end
	end

	describe 'comment#liked_by?' do 	
		it "returns whether comment has been liked by user" do
			@comment.liked_by @user
			expect(@comment.liked_by?(@user)).to be true
		end
	end

	describe 'comment#toggle_upvote_from' do 
		it "upvotes a non upvoted comment" do 
			@comment.unliked_by @user
			@comment.toggle_upvote_from @user
			expect(@comment.get_upvotes.size).to eq 1
			expect(@user.karma).to eq 1
		end

		it "downvotes an upvoted comment" do 
			@comment.liked_by @user
			@user.update_attributes karma: 1
			@comment.toggle_upvote_from @user
			expect(@comment.get_upvotes.size).to eq 0
			expect(@user.karma).to eq 0
		end
	end

	describe 'comment#formatted_body' do 
		it "replaces new lines with <br> tags" do 
			comment = create :comment, body: "1\n2\n3\n\n4", user_id: @user.id
			expect(comment.formatted_body).to eq "1<br>2<br>3<br><br>4"
		end
	end
end