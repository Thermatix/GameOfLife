class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :GridBlankCheck, :only => [:InitGrid]

@rows = 100
@colmns = 100
@gridE = false
  	 Init_grid(@rows,@colmns)

  	 loop #Main program update loop

  	 do

def GridBlankCheck

  @gridE = true if @grid != ""

end


  def InitGrid](rows, colmns)

    if !@gridE 
      @grid = Hash.new
      for x in 0..colmns
          for y n 0..rows
           @grid[[x,y]] = 0
         end 
      end
      PopulateGrid(rows, colmns)
      @gridE = true
    end
  end

  def PopulateGrid(rows, colmns)

for x in 0..colmns
        for y n 0..rows
          r = rand(10)
          if r < 6
            @grid[[x,y]] = 0
          else
            @grid[x,y] = 1
          end
          

        end 
    end
  end

end
