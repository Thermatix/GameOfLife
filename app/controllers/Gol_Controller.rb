require "SessionControl"
class GolController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
	def index
		@session = SesionControl.new
		@rows = 20
		@colmns = 20
		@stack = Stack.new(@rows,@colmns, @session.id)    
		@stack.StepForward()

	end


end
