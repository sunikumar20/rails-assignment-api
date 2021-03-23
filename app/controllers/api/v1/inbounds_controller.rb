class Api::V1::InboundsController < ApplicationController

	# Request:
	# POST /api/v1/inbounds/sms
	# params: { sms: {to: '', from: ''}}
	def sms
		service = SmsService.new(@account, params[:controller], sms_params)
		render json: service.response_data, status: service.status
	end

	private

	def sms_params
	  params.require(:sms).permit(:to, :from, :text)
	end
end