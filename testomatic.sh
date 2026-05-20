#!/bin/bash

# Andre's quick and dirty checker

# This project is licensed under the MIT License
# Read the license file on the root folder of this project for more
# information.

# Copyright (C) 2026 Andre Grindstaff


# Testing parameters
# ------------------------

# ------
# Note: setting these values in the testomatic script itself is no 
# longer necessary.
# ------

#PROJECT="pa04"
#PROJECT_FILE="$PROJECT.cpp"
#WORKING_DIR="~/cs135/pa03"
    # default WORKING_DIR="."

#CLASSID=cs135-wchoi-thu
#TURNIN_CMD='turnin -c $CLASSID -p $PROJECT'$WORKING_DIR/$PROJECT_FILE''

#TEST_RANGE_START=0
#TEST_RANGE_END=8

# ------------------------

# do not change these values below!

# init

ver="0.1.4.0"
has_config=0
has_parent_env=0
has_project_env=0
eval WORKING_DIR=$WORKING_DIR   # fix path
TURNIN_CMD="$TURNIN_CMD"        # fix path for turnin cmd

declare -i a b fail_count

get_config () {
	if [ -n "$TESTOMATIC_PATH" ]; then
		cust_config_parent=$(dirname "$TESTOMATIC_PATH")
		# will evaluate later if there is a testomatic.cfg or
		# config.cfg file
	fi
	
	# we start with the files that have the lowest precedence...
	
	# 0.1.5.x should have a warning if multiple testomatic dirs exist!
	
    if [ -f "$HOME/testomatic.cfg" ]; then
        config_path="$HOME/testomatic.cfg"
        has_config=1
    if [ -f "$HOME/.testomatic.cfg" ]; then
        config_path="$HOME/.testomatic.cfg"
        has_config=1
    elif [ -f "$HOME/.testomatic/config.cfg" ]; then
        config_path="$HOME/.testomatic/config.cfg"
        has_config=1
    elif [ -f "$HOME/testomatic/config.cfg" ]; then
        config_path="$HOME/testomatic/config.cfg"
        has_config=1
        
    # check if there is a config.cfg or testomatic.cfg in the testomatic
    # path
    elif [ -f "$TESTOMATIC_PATH/config.cfg" ]; then
        config_path="$TESTOMATIC_PATH/config.cfg"
        has_config=1
    elif [ -f "$TESTOMATIC_PATH/testomatic.cfg" ]; then
        config_path="$TESTOMATIC_PATH/testomatic.cfg"
        has_config=1
    elif [ -f "$cust_config_parent/testomatic.cfg" ]; then
        config_path="$cust_config_parent/testomatic.cfg"
        has_config=1
    elif [ -f "$cust_config_parent/config.cfg" ]; then
        config_path="$cust_config_parent/config.cfg"
        has_config=1
        
    # testomatic.cfg in the current directory takes the highest
    # precedence (aside from the environment specific ones)
    elif [ -f "$PWD/testomatic.cfg" ]; then
        config_path="$PWD/testomatic.cfg"
        has_config=1
    elif [ -f "$PWD/.testomatic.cfg" ]; then
        config_path="$PWD/.testomatic.cfg"
        has_config=1
    fi


    if [ $has_config == 1 ]; then
        # import values
        source "$config_path"
        # look for envs
        if [ ! $use.local_project_env == 0 ]; then
                env_parent=$(dirname "$WORKING_DIR")

                if [ -f "$env_parent/.testomatic.env" ]; then
                    source "$env_parent/.testomatic.env"
                    has_parent_env=1
                fi

                env_project="$WORKING_DIR"

                if [ -f "$env_project/.testomatic.env" ]; then
                    source "$env_project/.testomatic.env"
                    has_env=1
                fi
        fi


    fi

}

chk_config () {
    # check working dir (this may not be the actual directory the
    # user is in.
    if [ -d "$WORKING_DIR" ]; then
        if [ ! -f "$WORKING_DIR/$PROJECT_FILE" ]; then
            echo "[ERROR] The project file ['$PROJECT_FILE'] is not valid or is inaccessible. Please correct your configuration file."
            exit 2
        fi    
    else
        echo "[ERROR] The working directory ['$WORKING_DIR'] is not valid, does not exist, or is inaccessible. Please correct your configuration file."
        exit 2
    fi
}

auto_checker () {
    banner      # I am Mr. Banner :)
    let a=$TEST_RANGE_START
    let b=$TEST_RANGE_END
    let fail_count=(a + b + 1)  # + 1 to count 0
    for i in $(seq "$TEST_RANGE_START" "$TEST_RANGE_END"); do
        input="$PROJECT-input$i.txt"
        output="$PROJECT-output$i.txt"


        echo "Testing with inputs $i:"
        output_result=$(judge -p "$WORKING_DIR/$PROJECT" -i \
            "$WORKING_DIR/$input" -o "$WORKING_DIR/$output" -t 1)
        output_grade=$(echo "$output_result" | tail -n 1)
        output_grade_eval=$(echo "$output_grade" | grep -c 'AC')
             # this will "count" where it was a success or not
        if [ $output_grade_eval -eq 1 ];
        then
            echo "$output_grade"
            let --fail_count
            # this was changed to make sure that will more obvious that
            # some error while processing occurred to the user
            
        else
            judge -p "$WORKING_DIR/$PROJECT" -i "$WORKING_DIR/$input" \
                -o "$WORKING_DIR/$output" -t 1 -v
        fi
        echo -----------------------------------------------------------
        echo
    done


    echo All tests are complete
    if [ $fail_count -eq 0 ];
    then
        echo RESULTS: ALL PASSED
    else
        echo RESULTS: $fail_count were not correct.
        echo Review the results above. Please correct them.
    fi
    echo
}

easy_submit () {
    echo
    echo "Submit assignment now? (y,n)"
    read -t 10 -r -p "(y,n)" user_input
    if [ "$user_input" == "y" ];
    then
        echo
        eval $TURNIN_CMD
    fi
    echo
}

banner () {
    echo "Andre's [not so] quick and dirty tester and submitter"
    echo "Testomatic v$ver"
    echo "==============="
    echo "(C) 2026 Andre Grindstaff"
    echo
}

help () {
    banner
    echo "Parameters:"
    echo "  --help"
    echo "  help        Shows this screen"
    echo
    echo "  submit      Go to straight into submitting mode"
    echo "  test        Only test"
    echo

    diag_info
}

diag_info () {

    if [ $has_config == 1 ]; then
        echo "  Configuration file is present"
        echo
        echo "Configuration and Environment Variables:"
        echo "  Main configuration file:    $config_path"
        echo "  Class environment:          $env_parent"
        if [ $has_parent_env == 1 ]; then
            echo "                              [Enabled]"
        else
            echo "                              [Not configured]"
        fi
        echo
        echo "  Project environment:        $env_project"
        if [ $has_project_env == 1 ]; then
            echo "                              [Enabled]"
        else
            echo "                              [Not configured]"
        fi
        echo
    fi

    echo "Selected options:"
    echo "  Project:    $PROJECT"
    echo "  Class:      $CLASSID"
    echo "  Command:    $TURNIN_CMD"
    echo "      [Note] This is the exact command that will be run if you submit"
    echo
    echo "  Test range start: $TEST_RANGE_START"
    echo "  Test range start: $TEST_RANGE_END"
    echo
    # more config will be loaded, to be implemented
}

if [ "$1" == "--help" ]; then
	get_config
    help
elif [ "$1" == "help" ]; then
    get_config
    help
else
	get_config
    chk_config
    
    if [ "$1" == "submit" ]; then
        easy_submit
    elif [ "$1" == "turnin" ]; then
        easy_submit
    elif [ "$1" == "test" ]; then
        auto_checker
    elif [ "%1" == "setup" ]; then
        echo not available
    else
        auto_checker
        easy_submit
    fi
    #goodbye
fi

exit 0
