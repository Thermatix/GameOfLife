
#require "GridS"

class GolController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
	def index
		@rows = 30
		@colmns = 30
		@stack = Stack.new(@rows,@colmns)    
		@stack.StepForward()

	end


end
