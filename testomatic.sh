#!/bin/bash

# Andre's quick and dirty checker

# This project is licensed under the MIT License
# Read the license file on the root folder of this project for more
# information.

# Copyright (C) 2026 Andre Grindstaff


# Testing parameters
# ------------------------
PROJECT="pa04"
PROJECT_FILE="$PROJECT.cpp"
WORKING_DIR="~/cs135/pa03"
    # default WORKING_DIR="."

CLASSID=cs135-wchoi-thu
TURNIN_CMD='turnin -c $CLASSID -p $PROJECT'$WORKING_DIR/$PROJECT_FILE''

TEST_RANGE_START=0
TEST_RANGE_END=2

# ------------------------

# do not change these values below!

# init

ver="0.1.3.0"

declare -i a b fail_count

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
        #echo "$output_result"
        output_grade=$(echo "$output_result" | tail -n 1)
        output_grade_eval=$(echo "$output_grade" | grep -c 'AC')
             # this will "count" where it was
                                    # was a success or not
        #echo $output_grade_eval
        if [ $output_grade_eval -eq 1 ];
        then
            echo "$output_grade"
            let --fail_count
            #fail_count=($fail_count - 1)    # this backwards logic, makes sure
                                            # if it has some error processing

                                            # At least it'll be shown as an
                                            # issue to the user
        else
            judge -p "$WORKING_DIR/$PROJECT" -i "$WORKING_DIR/$input" \
                -o "$WORKING_DIR/$output" -t 1 -v
            #fail_count=($fail_count + 1)
        fi
        echo -----------------------------------------------------------
        echo
    done

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
    help
elif [ "$1" == "help" ]; then
    help
else
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
