class PhoneNumber < ApplicationRecord
	belongs_to :account
	# include Sms
	validates_length_of :number, minimum: 6, maximum: 16, message: 'min length 6 max length 16'

	def call_on_number(params)
		if (params[:call].blank?) 
			errors.add(:call, 'min length 1 max length 120') and return;
		end
		if (params[:to].blank?) 
			errors.add(:to, 'min length 6 max length 16') and return;
		end
		if (params[:from].blank?) 
			errors.add(:to, 'min length 6 max length 16') and return;
		end


		to = PhoneNumber.find(to: params[:to])
		from = PhoneNumber.find(to: params[:to])

		if (!to)
			
		end
	end
end
