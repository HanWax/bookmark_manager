helpers  do

	def current_user
		@current_user ||= User.get(session[:user_id]) if session[:user_id]
	end

	def hour_time_limit? time
		time >= (Time.now - 3600)
	end

end
