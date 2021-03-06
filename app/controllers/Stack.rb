class Stack

	#alive cells = 1, dead cells = 0

	def initialize(rows, colmns) #sets up object 
		@xr = rows
		@yc = colmns
		@gridInit = false
		GridCheck()
		@grid = Array.new(@xr) {Array.new(@yc) {rand(2)}} if !@gridInit #if there is no database grid it creates a new one and seeds it
		
		@gridstep = Array.new(@xr) {Array.new(@yc) {0}} #creates working grid
	
	end

	def GridCheck #checks to see if the database has data in it
		@gridthere = true
		@grid = Array.new(@xr) {Array.new(@yc)}
		@gridthere = PullGrid()	 
		if @gridthere
			@gridInit = true
		else
			@gridInit = false
		end



	end

	def grid(x,y)

		return @grid[x][y] #accessor for grid array
	end

	def StepForward
		#copies data from the database and puts it into the working grid
		PullGrid()
		Rails.logger.debug "copying data -SF1"
		for x in 0..@yc - 1
				for y in 0..@xr - 1
			@gridstep[x][y] = @grid[x][y]
			#Rails.logger.debug "row:#{x}"; Rails.logger.debug "column:#{y}"; Rails.logger.debug "value:#{@gridstep[x][y]}" 
			end
		end
		for x in 0..@yc - 1
			Rails.logger.debug @gridstep[x]
		end 
		cellTally = 0
		#performs rule checks for each cell and modifies them accourdingly
		Rails.logger.debug "tallying cells -SF2"
		for x in 0..@yc - 1
			for y in 0..@xr - 1
				cellTally = TallyCheck(x,y)
				@gridstep[x][y] = 0 if cellTally < 2
				@gridstep[x][y] = 0 if cellTally > 3
				@gridstep[x][y] = 1 if cellTally == 3
			end
		end
		for x in 0..@yc - 1
			Rails.logger.debug @gridstep[x]
		end 
		#moves data from working grid back to main grid
		Rails.logger.debug "moving data back to grid -SF3"
		for x in 0..@yc - 1
				for y in 0..@xr - 1
			@grid[x][y] = @gridstep[x][y]
		#	Rails.logger.debug "row:#{x}"; Rails.logger.debug "column:#{y}"; Rails.logger.debug "value:#{@grid[x][y]}" 
			end
		end
		for x in 0..@yc - 1
			Rails.logger.debug @grid[x]
		end 
		#saves the grid to the database
		Rails.logger.debug "Saving grid -SF4"
		SaveGrid()
	end	
	
	def SaveGrid #stores grid to the database
		Cells.delete_all
		savestring = ""
		for x in 0..@yc - 1
			for y in 0..@xr - 1

					if @grid[x][y] == 1
			       		savestring += "1"
			   		else
			   			savestring += "0"
			   		end
				


			       
			 end
		

			 
		end
		Rails.logger.debug savestring
   		gridsave = Cells.new(:cellstates =>  savestring)
		gridsave.save!
	end

	def PullGrid #pulls grid from the database returns false if no data is in the database, true if there is
		c = Cells.take()
		return false if c == nil
			for x in 0..@xr - 1
				for y in 0..@yc - 1
					Rails.logger.debug c
					@grid[x][y] = c.cellstates[(x*@xr) + y].to_i
				end
			end
		return true		
	end

	

	def TallyCheck(x,y) #tallys up alive(1) cells around the one it's looking at and returns the amount
		tally = 0
		tally += 1 if x > 0 && @gridstep[x - 1][y] == 1 
		tally += 1 if x <  @xr - 1 && @gridstep[x + 1][y] == 1
		tally += 1 if y > 0 && @gridstep[x][y - 1] == 1
		tally += 1 if y < @yc - 1 && @gridstep[x][y + 1] == 1 
		tally += 1 if x < @xr - 1 && y < @yc - 1 && @gridstep[x + 1][y + 1] == 1 
		tally += 1 if x > 0 && y > 0 && @gridstep[x - 1][y - 1] == 1 
		tally += 1 if x > 0 && y < @yc - 1 && @gridstep[x - 1][y + 1] == 1 
		tally += 1 if x < @xr - 1 && y > 0 && @gridstep[x + 1][y - 1] == 1 
		return tally
	end

end