# termSpawn
Spawns gnome-terminals based on input file
```
Usage: ./termSpawn.sh [OPTIONS]... [FILE]
Spawns terminal commands based on input file. File should contain commands seperated by newline character.
The following options should not be used together [l,o].

Optional arguments:
  -h, help            Displays this message
  -l, lolcat          Runs all terminals with lolcat (do not run with -o)
  -c, close terminal  Close the terminal after command execution
  -g, geometry        Set the terminal geometry. default=90x15
  -o, output dir      Redirects terminal outputs to directory in seperate files
```
