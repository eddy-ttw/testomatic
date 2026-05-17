#!/bin/bash

# Andre's quick and dirty checker

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

ver="0.1.1.4"


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


auto_checker
easy_submit

# tbd: add make easy submit optional/bypassable

# tbd: parm support/handler


#goodbye

exit 0
