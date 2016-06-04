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
		solve(start)
	end

	def solve(location)
		next_direction = list_cardinal_dir(location)
		if next_direction.include?(@end) then return true end
		next_direction.each do |dir|
			walk(dir[0], dir[1])
			reset_screen
			puts maze_visualization
			sleep(0.5)
			if solve(dir) then return "solved!" end
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

	def find_directions(location)
		return_array = []
		list_cardinal_dir(location).each do |coord|
			if traversable?(coord) then return_array << coord end
		end
		return_array
	end

	def list_cardinal_dir(location)
		return_array = [[location[0]-1, location[1]], [location[0]+1, location[1]], [location[0],location[1]-1], [location[0], location[1]+1]]
		return_array.delete_if do |row, column|
			!(0..@maze.size).include?(row) || !(0..@maze[0].size).include?(column)
		end
	end

	def traversable?(location)
		return true if @maze[location[0]][location[1]] == "."
		false
	end

	def walk(row, column)
		@maze[row][column] = "#"
	end

	def maze_visualization
		puts @maze
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



maze_solver = Solver.new
maze_solver.read_maze("map.1.txt")
# puts maze_solver.maze
# # maze_solver.reset_screen
# puts maze_solver.maze_visualization
# sleep(1)
# p maze_solver.start_solver