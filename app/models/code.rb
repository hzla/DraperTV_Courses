class Code < ActiveRecord::Base
	after_create :generate_body

	def generate_body
		update_attributes body: generate_code
	end

	def generate_code
		characters = (97..122).map {|x| x.chr}
		code = characters.map {|c| characters.sample}
		code.join[0..9].upcase
	end
 
end
