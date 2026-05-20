Testomatic: Andre's Quick and Dirty Checker 
Documentation for v0.1.4.0

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

1. Set up the environment, see the setting up section for more information.
2. Run testomatic.sh in a command line.
3. Receive the results of your work!
4. Choose whether to submit or not!


**SETTING UP:**

**Note:** It is highly recommended to put or symbolically link the
testomatic.sh to your ~/bin folder, or adding the folder holding the 
testomatic.sh script to your path, so you can use Testomatic in any
folder!

**Note:** For long term set ups, you should place your testomatic
configuration file in your local application settings directory 
(~/.config/) inside a testomatic directory (~/.config/testomatic/config.cfg),
or alternatively a testomatic.cfg in local application settings
(~/.config/testomatic.cfg).

This is preferred over creating a .testomatic directory directly in your home 
folder (~/) or having a testomatic.cfg in your home folder.



Configuration files (testomatic.cfg & testomatic.env): All settings 
should be set in your 'testomatic.cfg' configuration file!

Settings like mode should be in the the main configuration file
(testomatic.cfg). Settings like class ID, turn-in command, should be set
in the testomatic.env file in the class/parent folder.

Settings like testing range should be set in the testomatic.env file
in the project folder itself.

To better illustrate how this should be set up:

**Ideal setup:**

	~/ (your home directory)
	├── bin
	│   └── testomatic.sh **(the testomatic script/program)**
	│
	├── .config
	│   └── testomatic
	│   	└── config.cfg **(your main configuration file)**
	│				mode=0
	│				banner=0
	│				...	
	│
	│
	└── projects **(your projects parent folder)**   
		├── .testomatic.env (project environment config)
		│		turnin_cmd='turnin ...'
		│		project_file=$PROJECT.cpp
		│		...
		│
		│
	    └── hello world **(your example project folder)**
		   	├── helloworld.cpp (source code)
			│
		   	├── helloworld-input0.txt	(test input file)
		   	├── helloworld-output0.txt	(test output file)
			│
			└──	.testomatic.env	(project-specific config)


**Ideal setup (alternate):**

	~/ (your home directory)
	├── bin
	│   └── testomatic.sh **(the testomatic script/program)**
	│
	├── .config
	│   └── testomatic.cfg **(your main configuration file)**
	│			mode=0
	│			banner=0
	│			...	
	│
	│
	└── projects **(your projects parent folder)**   
		├── _.testomatic.env_ **(project environment config)**
		│		turnin_cmd='turnin ...'
		│		project_file=$PROJECT.cpp
		│		...
		│
		│
	    └── hello world **(your example project folder)**
		   	├── helloworld.cpp (source code)
			│
		   	├── helloworld-input0.txt	(test input file)
		   	├── helloworld-output0.txt	(test output file)
			│
			└──	_.testomatic.env_	(project-specific config)
	
	
**Plain:**
	~/ (your home directory)
	├── bin
	│   └── testomatic.sh **(the testomatic script/program)**	
	│
	├── projects **(your projects parent folder)**   
	│	├── .testomatic.env (project environment config)
	│	│		turnin_cmd='turnin ...'
	│	│		project_file=$PROJECT.cpp
	│	│		...
	│	│
	│	│
	│   └── hello world **(your example project folder)**
	│	   	├── helloworld.cpp (source code)
	│		│
	│	   	├── helloworld-input0.txt	(test input file)
	│	   	├── helloworld-output0.txt	(test output file)
	│		│
	│		└──	.testomatic.env	(project-specific config)
	│		
	└── testomatic.cfg **(your main configuration file)**
			mode=0
			banner=0
			...	


**Minimal / Basic: (starter configuration)**
	~/ (your home directory)
	├── bin
	│   └── testomatic.sh **(the testomatic script/program)**	
	│		
	└── testomatic.cfg **(your main configuration file)**
			mode=0
			banner=0
			...	


You may start with a minimal / basic set up at first, but it is
recommended to create the .testomatic.env configuration files in your
projects (parent) and project folders for better flexibility!

In the future, there will be a function to create or modify environment
configuration files will be added in a future release!

Placing 'testomatic.cfg' directly in your home folder or creating a
'.testomatic/' folder in your home folder is discouraged. (It creates
clutter in your home folder.)

If you want the configuration file to be hidden, you can add a period
or dot (.) to start of the filename. This is only supported when placed
in the home directory or the current directory. This behavior is by
design. (When the configuration file is placed in the proper location,
it really shouldn't be hidden.)


You also can redefine your testomatic configuration folder by using the
system user variable 'TESTOMATIC_PATH' to point to an alternate folder
or file location. Naming the configuration file other than 'config.cfg'
or 'testomatic.cfg' is not supported. 




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


**CHANGELOG:**
+ Configuration file support: You can set all the parameters, project, class,
testing range, and more! No more hard coding! Learn more in the features 
section!
+ Project environment support: Testomatic can automatically detect what
directory you are in, but also can use class/project-wide and project-
specific parameters and settings depending what folder you are in!
You can go from project folder to another and not have to update your
configuration files!

+ New configuration file template

* FIXED: The fail counter code to show results was missing. It has been
added in this release.
* Readme updated to reflect new functionality



**FEATURES:**
* Auto Checker: Tells you how many you got right (and wrong)! It'll just
show the short result for each correct in/output. But will print the full
verbose output if wrong.

* Easy submit: Submit JUDGE assignment after you test the program! Easy submit 
allows you to submit your assignment without having to type that  long command!
But you can now also type the following to submit now:
    'testomatic submit'
    
* Configuration file support: You can set all the parameters, project, class,
testing range, and more! You can start now by copying the:
	'testomatic.template.cfg'
		to 
	'testomatic.cfg'
	
	(where you should place your configuration files and testomatic are 
	explained in the _Setting Up_ section)


* Environment configuration support: Not only can set settings in your
testomatic.cfg file, you can have a project-specific one in that directory
of your project! But also per class!

* Check your config!: You now can show a screen that shows all your Testomatic 
environment confiruation. The project you're working on, the class name, the
testing range and more!

* Help screen: You can see how to use the new submit only mode and get
information about the Testomatic configuration.
	'testomatic --help'

