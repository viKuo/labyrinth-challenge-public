require_relative 'solver'
require_relative 'stack'
require_relative 'queue'

maze_solver = Solver.new
maze_solver.read_maze("map.2.txt")
maze_solver.reset_screen
maze_solver.maze_visualization
# stack = Stack.new
# push = Proc.new { |element| stack.push(element) }
# pop = Proc.new { stack.pop }
# maze_solver.solve_iteratively(push, pop)

queue = Queue.new
enqueue = Proc.new { |element| queue.enqueue(element) }
dequeue = Proc.new { queue.dequeue }
maze_solver.solve_iteratively(enqueue, dequeue)