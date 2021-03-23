class Api::V1::OutboundsController < ApplicationController
	before_action :block_api_request

	# Request:
	# POST /api/v1/outbounds/sms
	# params: { sms: {to: '', from: ''}}
	def sms
		service = SmsService.new(@account, params[:controller], sms_params)
		render json: service.response_data, status: service.status
	end

	private

	def sms_params
	  params.require(:sms).permit(:to, :from, :text)
	end

	def block_api_request
		if params[:sms][:from].present?
			key = "block-api-request:from:#{params[:sms][:from]}-counter"
			counter = $redis.get(key).to_i
			counter += 1
			if counter > 3
				$redis.expire(key, 24.hours) 
				render json: { error: "limit reached for from #{params[:sms][:from]}" }, status: 404 and return
			end
			$redis.set("block-api-request:from:#{params[:sms][:from]}-counter", counter)
		end
	end
end