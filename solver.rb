require_relative 'reset_screen'

class Solver
	attr_reader :maze
	def read_maze(file)
	  @maze = []
	  File.open(file).each do |file_row|
	    @maze << file_row.chomp.split('')
	  end
	  @maze
	end

	def start_recursive_solver
		start_coordinate = find_coordinate{ "o" }
		@end_coordinate ||= find_coordinate{ "*" }
		solvable?(solve_recursively(start_coordinate))
	end

	def solve_iteratively(put_in, take_out)
		start_coordinate = find_coordinate{ "o" }
		@end_coordinate ||= find_coordinate{ "*" }
		location = start_coordinate
		finished = false
		until finished == true
			directions = list_possible_directions(location)
			directions.each do |direction|
				put_in.call(direction)
			end
			location = take_out.call
			break if location == nil
			walk(location[0], location[1])
			visualize_step
			location == @end_coordinate ? finished = true : finished = false
		end
		solvable?(finished)
	end

	def solve_recursively(location)
		return true if location == @end_coordinate
		next_direction = list_possible_directions(location)
		next_direction.each do |dir|
			walk(dir[0], dir[1])
			visualize_step
			result = solve_recursively(dir)
			if result == true then return true end
		end
		false
	end

	def solvable?(boolean)
		if boolean
			puts "Solved!"
		else
			puts "Unsolvable"
		end
	end

	def find_coordinate
		@maze.each_index do |row|
			@maze[row].each_index do |column|
				if @maze[row][column] == yield
					return [row, column]
				end
			end
		end
	end

	def list_possible_directions(location)
		list_cardinal_dir(location).select { |coord| traversable?(coord) }
	end

	def list_cardinal_dir(location)
		return_array = [[location[0]-1, location[1]], [location[0]+1, location[1]], [location[0],location[1]-1], [location[0], location[1]+1]]
		return_array.reject do |row, column|
			!(0...@maze.size).include?(row) || !(0...@maze[0].size).include?(column)
		end
	end

	def traversable?(location)
		if @maze[location[0]][location[1]] == "." || @maze[location[0]][location[1]] == "*" then return true end
		false
	end

	def visualize_step
		reset_screen
		maze_visualization
		sleep(0.2)
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

