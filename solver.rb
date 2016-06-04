require_relative 'reset_screen'

class Solver
	attr_reader :maze
	#This method reads a file into a 2D array. See `spec/solver_spec.rb`
	def read_maze(file)
	  @maze = []
	  File.open(file).each do |file_row|
	    @maze << file_row.chomp.split('')
	  end
	  @maze
	end

	def start_solver
		start = find{ "o" }
		@end ||= find{ "*" }
		if solve_recursively(start) == true
			puts "Solved!"
		else
			puts "Unsolvable"
		end
	end

	def solve_iteratively(put_in, take_out)
		start = find{ "o" }
		@end ||= find{ "*" }
		location = start
		finished = false
		until finished == true
			directions = list_possible_directions(location)
			directions.each do |direction|
				put_in.call(direction)
			end
			location = take_out.call
			walk(location[0], location[1])
			reset_screen
			maze_visualization
			sleep(0.5)
			location == @end ? finished = true : finished = false
		end 
	end

	def solve_recursively(location)
		next_direction = list_possible_directions(location)
		return true if next_direction.include?(@end)
		return false if next_direction.empty?
		next_direction.each do |dir|
			walk(dir[0], dir[1])
			reset_screen
			maze_visualization
			sleep(0.5)
			result = solve(dir)
			if result == true then return true end
		end
	end

	def find
		@maze.each_index do |row|
			@maze[row].each_index do |column|
				if @maze[row][column] == yield
					return [row, column]
				end
			end
		end
	end

	def list_possible_directions(location)
		return_array = []
			list_cardinal_dir(location).each do |coord|
			if traversable?(coord) then return_array << coord end
		end
		return_array
	end

	def list_cardinal_dir(location)
		return_array = [[location[0]-1, location[1]], [location[0]+1, location[1]], [location[0],location[1]-1], [location[0], location[1]+1]]
		return_array.delete_if do |row, column|
			!(0...@maze.size).include?(row) || !(0...@maze[0].size).include?(column)
		end
	end
 
	def traversable?(location)
		if @maze[location[0]][location[1]] == "." || @maze[location[0]][location[1]] == "*" then return true end
		false
	end

	def walk(row, column)
		@maze[row][column] = "x"
	end

	def maze_visualization
		@maze.each do |row|
			p row.join
		end
	end

	# The following methods will help us
# to update the screen when printing the board.
# We don't need to test these methods.
def reset_screen
  clear_screen
  move_to_home
end

# Clears the content on the screen. Ah, a fresh canvas.
def clear_screen
  print "\e[2J"
end

# Moves the insert point in the terminal back to the upper left.
def move_to_home
  print "\e[H"
end
end

