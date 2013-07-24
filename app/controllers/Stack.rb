class Stack# < ActionController::Base


#before_filter :GridBlankCheck, :only => [:InitGrid]
@gridInit = false

	
	def initialize(rows, colmns)
		@xr = rows
		@yc = colmns
		@grid = Array.new(@xr) {Array.new(@yc) {rand(2)}}
		@gridInit = true
	
	


	end
	def grid(x,y)

		return @grid[x][y]
	end
	


	def SaveGrid()

	
		for x in 0..@yc - 1
			for y in 0..@xr - 1

					if @grid[x][y] == 1
			       		cellstate = true
			   		else
			   			cellstate = false
			   		end
					gridsave = Cells.new(:alive => cellstate, :x => x, :y => y)
			       gridsave.save!


			       
			 end
		end
		
   
	end

	def PullGrid()
		
			for x in 0..@yc - 1
				for y in 0..@xr - 1

					

				if Cells.where("x = ? AND y = ?",x,y).take().alive
					@grid[x][y] = 1
				else
					@grid[x][y] = 0
				end


				

				end
			end

		end
end