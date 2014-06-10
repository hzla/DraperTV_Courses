class SentEmailOpen < ActiveRecord::Base
	  attr_accessible :name, :email, :ip_address, :opened
end
