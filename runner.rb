require_relative 'solver'
require_relative 'stack'
require_relative 'queue'

maze_solver = Solver.new
maze_solver.read_maze(ARGV[1])
maze_solver.reset_screen
maze_solver.maze_visualization

case ARGV[0]
when "stack"
  stack = []
  #stack = Stack.new
  push = Proc.new { |element| stack.push(element) }
  pop = Proc.new { stack.pop }
  maze_solver.solve_iteratively(push, pop)
when "queue"
  queue = []
  #queue = Queue.new
  enqueue = Proc.new { |element| queue.push(element) }
  dequeue = Proc.new { queue.shift }
  maze_solver.solve_iteratively(enqueue, dequeue)
when "recursive"
  maze_solver.start_recursive_solver
else
  puts "Visualize the solving with 'stack', 'queue', or 'recursive'"
end
