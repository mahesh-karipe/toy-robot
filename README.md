# toy-robot

## Running the program

### From IRB
```
require_relative 'lib/simulator'
input = %{
PLACE 1,0,NORTH
MOVE
REPORT
}
Simulator.run(input)
```

### From Terminal
```
$ cd <project-dir>
$ ruby main.rb < <input-file-name>
```

## Running Tests
```
$ cd <project-dir>
$ bundle install
$ rspec
```

## Running examples
```
$ cd <project-dir>
$ ruby main.rb < examples/example_a
$ ruby main.rb < examples/example_b
$ ruby main.rb < examples/example_c
$ ruby main.rb < examples/example_d
```
