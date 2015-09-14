class Code < ActiveRecord::Base
	after_create :generate_body
	validates_uniqueness_of :body

	def generate_body
		update_attributes body: generate_code
	end

	private

	def generate_code
		characters = (97..122).map {|x| x.chr}
		code = characters.map {|c| characters.sample}
		code.join[0..9].upcase
	end
 
end
