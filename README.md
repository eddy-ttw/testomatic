Testomatic: Andre's Quick and Dirty Checker 
Documentation for v0.1.2.1

Created and written by: Andre Grindstaff (andre.grindstaff@student.csn.edu)

This project is licensed under the MIT License. View the 'LICENSE' file
on the root folder of the project for more information.


**HISTORY:**
Testomatic is a shell script I wrote about a month into my C++ class at the
College of Southern Nevada. The goal was in part to learn how to write Linux
shell scripts, but actually it was to automate the testing of assignments in
class. After the 3rd or so assignment, we had to test our programs with a tool
called "judge," which itself is a program that automates the testing of
command line programs. You may ask yourself, "why would I make a script to 
automate testing for a program that already does automated testing?"

That is a great question, the answer simply is that JUDGE automates only the
testing of inputs and outputs, with only a single set... Say you have 10 input
scenarios you have to test, having to change the input & output test file for
each instance would get tedious quick! Not to mention if you were debugging a
program that worked in the first and second scenarios, but not in the third.
Being able to quickly check the results of your program with the expected
output, just made the process so much easier!

*Unfortunately, as I was writing this script, I neglected to bother to set up a
GIT repository for it, as I didn't intend on sharing the code. So I found an
early-ish version... so here it is.

So I put together roughly what would have been the initial version, I worked a
little *TOO* hard on this project that it did cut a little into the time to
work on my 4th, 5th, and 6th assignments! It was too much fun to work on.
That also meant this project went under rapid development! So, versions
incremented quickly, which makes this a nightmare to document after the fact!


**HOW TO USE**:
Preamble: This is such an early* version, you edit the shell script directly to
change what project file, project directory, and the testing range (as the 
suffix).

1. Set up the environment, see the setting up section for more information.
2. Run testomatic.sh in a command line.
3. Receive the results of your work!
4. Choose whether to submit or not!


**SETTING UP:**

Project [executable] (PROJECT=project): The name of the project executable to
test with and the project name.

    For example: Programming assignment #4 would be written as 'pa04' the
    executable is also name 'pa04'
    In testomatic, you write this as "PROJECT=project" -> "PROJECT=pa04"


    Note: This variable can also be used as part of forming the project
    filename (e.g '$PROJECT.cpp') if so, the project source file and the
    project executable must be same for this to work correctly.

    Note: By default, testomatic is set to follow this convention of deriving
    the project source and executable using the 'PROJECT' variable. You can
    change this in the testomatic.sh script file. (do not change it)

    **Important: This is the only supported method.** Having different project
    executable and project source code prefixes is not supported at this time.


    **DO NOT USE THE FULL FILE PATH HERE** (hint: full paths should be entered
    using 'WORKING_DIR')


Project file (PROJECT_FILE=$PROJECT.cpp): The filename of the project file
    source code.

    For example: Project 'pa04' source code file is 'pa04.cpp'
    In testomatic, you write this as "PROJECT_FILE=src.c" -> "PROJECT=pa04.cpp"


    **Using PROJECT variable to derive the executable or source name:**
    Note: You can use the 'PROJECT' variable to form the name of the file.
    More info is available at the entry for project executable above.

        **EXAMPLE:** My project is in pa04 folder, the source code is pa04.cpp,
        the source code and executable names are prefixed by the project name, 
        so we use the project variable (PROJECT=pa04) to set 
        PROJECT_FILE=$PROJECT.cpp    

    
Project directory (working directory) (WORKING_DIR=~/projects/test):
    The location of the project directory/folder.

    Note: Testomatic assumes your source, executable, and input files are
    stored in the same folder. Altering this behavior is not supported at this
    time.
 

Test range (TEST_RANGE_START=0) and (TEST_RANGE_END=2): 
    This sets the amount of test input and output files to use to check your
    project program. In this version, the ranges are treated simply as suffixes.

    The project name, source, and executable must start with the same name /
    with the same prefix.
    
    This is a limitation of this version.


**FEATURES:**
+ Auto checker now tells you how many you got right (and wrong)! It'll just
    show the short result for each correct in/output. But will print the full
    verbose output if wrong.
+ Easy submit command is now shown as a variable!
    (Easy submit allows you to submit your assignment without having to type that 
    long command!)
+ Banner added!

