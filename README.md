# Labyrinth

> "So it was that the hero met the Minotaur in the gloomy depths of the Labyrinth and was not afraid." —Theseus and the Minotaur

In this challenge you will need to create a program that can solve mazes. You will build a program step by step to:

 * Read in a file containing the Maze
 * Represents the Maze in code
 * Uses a strategy to determine if the Maze is solvable
 * Visualizes (animates) your strategy to show it in action

**Make sure you test**. This challenge can easily go awry if you're not careful testing even your most basic methods. For example, a simple bug like mixing up x and y could have some confusing and non-obvious consequences.

## Release 1, Reading the Maze

Your maze will be defined in a text file that looks like this:

```
o#........
.#####.##.
.......##.
######.#*.
.......###
```

 * `#` is a wall
 * `.` is an open tile
 * `o` is your start point
 * `*` is your goal

The maze does not "wrap", this isn't Pac-Man.

### Constraints

Unlike a true Labyrinth, our Mazes _will not double back on themselves_. For example, this is invalid:

```
o#........
.#.###.##.
.......##.
######.#*.
.......###
```

See how you can go around in a circle (look at coordinate `2,1`)? Make sure your maps do not have any of these "cycles."

_Note: For the same reason, hallways will always be one tile wide_

### Reading a file

You can read a file in with Ruby's `File` class. The easiest way to do this is to use `File.read`. For example:

```ruby
map_string = File.read('my_map.txt')
```

### Representing a Maze

Once you have the Maze file read into a String, you will need to convert the string into some data structure that will help you work with it in _code_. A big string is pretty hard to work with when you're thinking about different kinds of cells, or where the coordinates of things are on the map.

Ask yourself these questions:

 * What kinds of things might I need to do with my maze?
 * How can I represent the maze in a way that will help me do the above in my code?

Later, you may discover you need to work with your maze in ways you didn't anticipate. That's ok, don't be afraid to refactor how you represent it as you go.

There's a saying, "90% of programming is choosing the right data structures." Pick something simple and flexible to start, you can always change up later.

## Release 2, Visualize It

Now you have your maze represented as some kind of data structure in code. Write a method that takes this data structure and turns it _back_ into a String suitable for printing to your terminal. This isn't too complicated, but will be important when we start visualizing how our solving strategy works.

## Release 3, The Solver

Now the fun part. Your task is to write an algorithm that determines if a map is solvable or not. Your program can simply print out "Solvable" if there's a path from the start to the finish, or "Unsolvable" if no path exists. You do not need to actually return the path itself.

Make sure you test on different kinds of maps. A couple examples are contained in this repository.

### Think it Through

* How would _you_ solve it with pen and paper?
* Can a computer do it the way you did?
* If not, why? What kind of approach(es) might work for a computer?
* Can you break those steps down to a pseudocode algorithm?
* What sort of data structures will you use to keep track of things?

### Stuck? Transport yourself to Imagination Land

<img src='assets/imagine.gif' width='300px'>

Close your eyes and imagine yourself in the maze. It's pitch black and the you're standing on the start tile. You can drop a candle on each tile of the maze to illuminate the ones around it. How do you find your way to the end? Luckily there's no minotaur in this one (but it'd be pretty sweet if you added it later).


## Release 4, Show and Tell

We want to visualize the search pattern of your algorithm as it works step-by-step. For example:

![](assets/dfs.gif)

You can animate your algorithm's progress by doing this with each step:

 * Clearing the screen (see below)
 * Printing out some representation of your map
 * `sleep(0.1)` to make things pause between steps

This will help you see what's happening as you attempt to solve a maze.

You can use this to clear the screen between print statements:

```ruby
def clear_screen
  print "\e[2J\e[f"
end
```

What does your algorithm's search pattern look like? Commit a description in `notes.md`.


## Stretch: Harder Mazes & Open Terrain

Let's relax the constraints on our maps. Before we didn't have wide hallways, open terrain, or "cycles." Now we will.

```
...#.....#
...#.#.#.#
...#.#.#.#
.#...#.#*#
.#########
........o.
####.#####
..........
.###.####.
...#......
```


```
.................
........#........
........#.*......
........#........
........#........
........#........
........#........
........#........
........#........
.o......#........
........#........
.................
```

Does your algorithm still work? If not, why? What about this change is causing your strategy to fail? You might go back to imagination land and start dropping candles again.

Figure out how you need to change your approach to account for these new requirements. In addition to fixing your code, describe what went wrong in `notes.md`. If your code worked from the start, describe why.

## Stretch: Strategery
You have one solving strategy, now try building another.

One should look something like this:

![](assets/dfs.gif)

And the other should look like this:

![](assets/bfs.gif)

See the difference? When a branch is encountered, one seems to follow a path entirely before trying something else. The other explores all paths, one cell at a time. Believe it or not, these two approaches are basically the same except for one minor detail.
