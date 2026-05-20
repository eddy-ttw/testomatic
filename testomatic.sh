#!/bin/bash

# Andre's quick and dirty checker

# This project is now licensed under the MIT License

# Copyright (C) 2026 Andre Grindstaff

# Read 'LICENSE' for more information.


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

ver="0.1.2.1"

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
            fail_count=($fail_count - 1)
        else
            judge -p "$WORKING_DIR/$PROJECT" -i "$WORKING_DIR/$input" \
                -o "$WORKING_DIR/$output" -t 1 -v
            fail_count=($fail_count + 1)
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
	# tbd
}


auto_checker
easy_submit

# tbd: add make easy submit optional/bypassable

exit 0
