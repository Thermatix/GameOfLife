class SessionControl < ActionController:Helpers

	protect_from_forgery with: :exception
	
	def initialize 
		if !cookies[:id]	
		cookies[:id] = { value: request.session_options[:id], expires: 1.hour.from_now}
		end
		#@session_id = cookies[:id]
	end

	def Id
		return cookies[:id].value
		return cookies[:id].value
	end

end