class Stack# < ActionController::Base


#before_filter :GridBlankCheck, :only => [:InitGrid]


	
	def initialize(rows, colmns)
		@xr = rows
		@yc = colmns
		
		@grid = Array.new(@xr) {Array.new(@yc) {rand(2)}} if !@gridInit
		@gridInit = true
		@gridstep = Array.new(@xr) {Array.new(@yc) {0}}
	


	end
	def grid(x,y)

		return @grid[x][y]
	end

	def StepForward
		PullGrid()
		Rails.logger.debug "copying data -SF1"
		for x in 0..@yc - 1
				for y in 0..@xr - 1
			@gridstep[x][y] = @grid[x][y]
			Rails.logger.debug "row:#{x}"; Rails.logger.debug "column:#{y}"; Rails.logger.debug "value:#{@gridstep[x][y]}" 
			end
		end

		cellTally = 0
		Rails.logger.debug "tallying cells -SF2"
		for x in 0..@yc - 1
			Rails.logger.debug "row:#{x}"
			for y in 0..@xr - 1
				Rails.logger.debug "column:#{y}"
				Rails.logger.debug "Before Tally Value:#{@gridstep[x][y]}"
				cellTally = TallyCheck(x,y)
				Rails.logger.debug "Tally count:#{cellTally}"
				@gridstep[x][y] = 0 if cellTally < 2
				@gridstep[x][y] = 0 if cellTally > 3
				@gridStep[x][y] = 1 if cellTally == 3
				Rails.logger.debug "After tally Result:#{@gridstep[x][y]}"
			end
		end
		Rails.logger.debug "moving data back to grid -SF3"
		for x in 0..@yc - 1
				for y in 0..@xr - 1
			@grid[x][y] = @gridstep[x][y]
			Rails.logger.debug "row:#{x}"; Rails.logger.debug "column:#{y}"; Rails.logger.debug "value:#{@grid[x][y]}" 
			end
		end
		Rails.logger.debug "Saving grid -SF4"
		SaveGrid()
	end	
	
	def SaveGrid

	
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

	def PullGrid
		
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

	

	def TallyCheck(x,y)
		tally = 0
		tally + 1 if x > 0 && @gridstep[x - 1][y] == 1 
		tally + 1 if x <  @xr - 1 && @gridstep[x + 1][y] == 1
		tally + 1 if y > 0 && @gridstep[x][y - 1] == 1
		tally + 1 if y < @yc - 1 && @gridstep[x][y + 1] == 1 
		tally + 1 if x < @xr - 1 && y < @yc - 1 && @gridstep[x + 1][y + 1] == 1 
		tally + 1 if x > 0 && y > 0 && @gridstep[x - 1][y - 1] == 1 
		tally + 1 if x > 0 && y < @yc - 1 && @gridstep[x - 1][y + 1] == 1 
		tally + 1 if x < @xr - 1 && y > 0 && @gridstep[x + 1][y - 1] == 1 
		Rails.logger.debug "tally check:#{tally}"
		return tally
	end
end