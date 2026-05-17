#!/bin/bash

# Andre's quick and dirty checker

# ---
# NOTE:
# This is the earliest version of the 0.1.x available
# ---

# Testing parameters
# ------------------------
PROJECT="pa04"
PROJECT_FILE="$PROJECT.cpp"
WORKING_DIR="~/cs135/pa03"
    # default WORKING_DIR="."

CLASSID=cs135-wchoi-thu

TEST_RANGE_START=0
TEST_RANGE_END=2

# ------------------------

# do not change these values below!

# init

ver="0.1.1.3"


auto_checker () {
    let a=$TEST_RANGE_START
    let b=$TEST_RANGE_END
    let fail_count=(a + b + 1)  # + 1 to count 0
    for i in $(seq "$TEST_RANGE_START" "$TEST_RANGE_END"); do
        input="$PROJECT-input$i.txt"
        output="$PROJECT-output$i.txt"


        judge -p "$WORKING_DIR/$PROJECT" -i "$WORKING_DIR/$input" \ 
			-o "$WORKING_DIR/$output" -t 1 -v
        
        echo
    done

}

auto_checker
# tbd: add auto submit
# tbd: parm support/handler


#goodbye

exit 0
