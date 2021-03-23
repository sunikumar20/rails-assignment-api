require 'redis'
class ApplicationController < ActionController::API
	before_action :authenticate_user!
	before_action :init_redis

	def init_redis
		$redis = Redis.new(host: "localhost")
	end

	def authenticate_user!
		@account = Account.find_by(username: request.headers['username'], auth_id: request.headers['password'])
		if !@account
			render json: { error: 'Authentication failed' }, status: 403
		end
	end
end
