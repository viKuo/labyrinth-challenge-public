require_relative '../solver'

describe "Solver" do
	let(:solver) { Solver.new }
	let(:file) { "#{File.dirname(__FILE__)}/map_test.txt" }
	let(:file2) { "#{File.dirname(__FILE__)}/map.1.txt" }

  it 'should read a maze into a 2D (nested) array' do
  	maze = solver.read_maze(file)
    maze_array = [['#','.','#'],
                  ['#','.','*'],
                  ['#','#','#']]
    expect(maze).to eq(maze_array)
  end

  it 'finds the start of the maze' do
  	solver.read_maze(file2)
  	expect(solver.find{ "o" }).to eq [0,0]
  end

  it 'finds the end of the maze' do
  	solver.read_maze(file2)
  	expect(solver.find{ "*" }).to eq [3,8]
  end

  it 'finds a wall not traversable' do
  	solver.read_maze(file2)
  	expect(solver.traversable?([0,1])).to eq false
  end

  it 'finds an open tile traversable' do
  	solver.read_maze(file2)
  	expect(solver.traversable?([0,2])).to eq true
  end

  it 'finds cardinal directions in the maze' do
  	solver.read_maze(file2)
  	expect(solver.list_cardinal_dir([2,6])).to eq [[1,6],[3,6],[2,5],[2,7]]
  end

  it 'finds cardinal directions on the edge' do
  	solver.read_maze(file2)
  	expect(solver.list_cardinal_dir([2,0])).to eq [[1,0], [3,0], [2,1]]
  end

  it 'finds walkable directions' do
  	solver.read_maze(file2)
  	expect(solver.find_directions([2,0])).to eq [[1,0], [2,1]]
  end

  it 'changes walked-on paths to # sign' do
  	solver.read_maze(file2)
  	expect { solver.walk(2,0) }.to change { solver.maze[2][0] }
  end

end

