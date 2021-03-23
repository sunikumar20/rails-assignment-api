class SmsService
	extend ActiveSupport::Concern
	attr_accessor :to, :from, :text, :response_data, :status, :account

	# included do
	# 	validates_length_of :to, minimum: 6, maximum: 16, message: 'min length 6 max length 16'
	# 	validates_length_of :from, minimum: 6, maximum: 16, message: 'min length 6 max length 16'
	# 	validates_length_of :text, minimum: 6, maximum: 16, message: 'min length 1 max length 120'
	# end

	def initialize(account, controller, params)
		@account = account
		@controller = controller
	   initialize_params(params)
	end

	private

	def initialize_params(params)
		validate_params(params)

		key = "to:#{params[:to]}-from:#{params[:from]}"
		pair_exists_in_cache?(key, params) if outbounds?

		set_from_and_to(params)

	    $redis.set(key, [@to, @from].as_json, ex: 4.hours) if outbounds?

	    unless @response_data
			@status = :ok
			@response_data = { "message": "inbound sms ok", "error": "" } and return
		end
	end

	def outbounds?
		@controller == 'outbound'
	end

	def validate_params(params)
		if (params[:to].blank?)
			@status = :bad_request
			@response_data = { message: '', error: 'to parameter is missing' } and return
		end
		if (params[:from].blank?) 
			@status = :bad_request
			@response_data = { message: '', error: 'from parameter is missing' } and return
		end

		key = "to:#{params[:to]}-from:#{params[:from]}"
		if outbounds?
			obj = $redis.get(key)
			if obj
				@status = 404
				@response_data = { "message": "", "error": "sms from #{params[:to]} to #{params[:from]} blocked by STOP request" } and return
			end
		end
	end

	def pair_exists_in_cache?(key, params)
		obj = $redis.get(key)
		if obj
			@status = 404
			@response_data = { "message": "", "error": "sms from #{params[:to]} to #{params[:from]} blocked by STOP request" } and return true
		end
	end

	def set_from_and_to(params)
		@to = @account.phone_numbers.find_by(number: params[:to])
		if (!@to)
			@status = :not_found
			@response_data = { message: '', error: 'to parameter not found'} and return
		end

		@from = @account.phone_numbers.find_by(number: params[:from])
		if (!@from)
			@status = :not_found
			@response_data = { message: '', error: 'from parameter not found'} and return
		end
	end
end