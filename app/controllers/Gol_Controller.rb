
#require "GridS"

class GolController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
	def index
		@rows = 20
		@colmns = 20
		@stack = Stack.new(@rows,@colmns)    
		@stack.StepForward()
			
		
		

		  	 
	end


end
