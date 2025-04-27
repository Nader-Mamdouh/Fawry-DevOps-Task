# mygrep.sh

`mygrep.sh` is a simple, shell-based implementation of the `grep` command. It allows users to search for a string within a file and provides options for displaying line numbers and inverting the match. It mimics the basic functionality of `grep` with a few extra options.

## Features
- **Case-insensitive search**: The script supports case-insensitive matching of the search string.
- **Line numbers**: Use the `-n` option to display line numbers along with the matched lines.
- **Invert match**: Use the `-v` option to show lines that do not contain the search string.
- **Multiple options**: Combine `-n` and `-v` (like `-vn` or `-nv`) to get both line numbers and inverted match results.
- **Help command**: Use `--help` to view the script's usage information.

## Usage

To use the script, run it from the terminal as follows:
./mygrep.sh [options] <search_string> <file>


## Breakdown of how the script handles arguments and options:
1) Initial Setup:
The script begins by defining a function show_help(), which displays usage instructions for the script. If the --help flag is passed as the first argument, this function is triggered, and the script exits after displaying the help message.
2) Option Parsing:
The script then initializes two flags (show_line_number and invert_match) to false, indicating the default behavior of the script (no line numbers, normal match).
The while loop checks for arguments that start with a - (options). For each option:
-n: Activates line numbers in the output.
-v: Inverts the match, displaying lines that do not match the search string.
-vn or -nv: Both options enable line numbers and inverted matching.
--help: Calls the show_help() function to display usage information.
If an invalid option is passed, the script outputs an error message and shows the help information.
3) Shifting Arguments:
After processing options, the shift command is used to move past the options, allowing $1 and $2 to represent the search string ($search_string) and the file name ($search_file).
4) Argument Validation:
The script checks if either the search string or the file name is missing. If either is missing, an error message is displayed, and the help message is shown.
It also checks if the file exists using [[ ! -f "$search_file" ]]. If the file doesn't exist, an error message is displayed, and the script exits.
5) Search Logic:
The script reads the file line by line using a while loop.
For each line, it checks if the line matches the search string using the =~ operator, which allows for regex matching.
If the -v option is set (invert match), lines that do not match are displayed.
If the -n option is set (show line numbers), the line number is printed alongside the matching line.
The match variable determines whether the line matches the search string, and the options are used to determine whether to display the line based on the match result.

 ## A short paragraph: If you were to support regex or -i/-c/-l options, how would your structure change?
To support regex or options like -i (case-insensitive), -c (count matches), and -l (list matching filenames), I would modify the structure as follows:

1) Regex Support: The search string ($search_string) would be processed as a regex. I would update the search logic to handle regex matching using [[ "$line" =~ $search_string ]] for pattern matching.
2) -i Option: This would enable case-insensitive matching. I would convert both the line and search string to lowercase (or uppercase) before comparison to ensure case insensitivity.
3) -c Option: Instead of printing matches, I would count how many lines match the search criteria and print the total count.
4) -l Option: Instead of printing matching lines, I would print the filenames that contain the search string.
I would also modify the argument parsing logic to handle these new options, ensuring that they could be combined with others like -n, -v, and -vn. This would require an additional condition check within the search loop to handle different actions for each option.

## What part was the hardest?
1) Handling options together (-vn, -nv) without getopts can be tricky.
2) making sure the script behaves exactly like grep (especially in inverted mode).
3) After handling options, the script needs to correctly "shift" the arguments so that $1 is the search string and $2 is the filename. This can become confusing, especially when options are combined or if no options are passed at all.

## Screenshot of Terminal
In this screenshot, the script mygrep.sh is executed successfully in the terminal. The script performs a search for a specified string within a given file, with several options for controlling the output. I have also implemented error handling to ensure the script behaves correctly even when invalid inputs are provided.
The script can be customized with different options, such as showing line numbers or inverting the match, and it handles both valid and erroneous inputs gracefully. Feel free to try out the script for yourself and explore its functionality!
![Terminal Screenshot](https://github.com/Nader-Mamdouh/Fawry-DevOps-Task/blob/main/Custom_Command/Fawry%20Devops%20Task-Q1.png)
