#!/bin/bash
# Function: create_dynamic_block
# Description: This function creates a dynamic block with a phrase that is visible within a bordered box.
#              The box is created using the '#' character and the phrase is centered within the box.
# Parameters:
#   $1 - The phrase to be displayed within the dynamic block.
# Usage:
#   create_dynamic_block "Your phrase here"
# Example:
#   create_dynamic_block "Hello, World!"
# Notes:
#   - If no argument is provided, the function will print "Argument missing" and return with
#   - The total length of the block is set to 120 characters.
#   - The phrase will be centered within the block, with padding on either side.
#   - The block and the phrase are colored using ANSI escape codes (green for the block and red for the phrase).

# Create a dynamic block with a phrase so that it is visible
function create_dynamic_block() {
    if [ -z "$1" ]; then
        echo "Argument missing"
        return 1
    fi

    phrase="$1"

    # Block length
    total_length=120  

    # Calculate the padding for the middle row
    phrase_length=${#phrase}
    paddingLength=$(( (total_length - phrase_length - 2) / 2 ))

    # Define the colors to use in the echo
    RED='\033[0;31m' # Red
    GREEN='\033[0;32m'  # Green
    NC='\033[0m' # No color


    # Print the first row, this is the total length
    for ((i = 0; i < total_length; i++)); do
        echo -n -e "${GREEN}#${NC}"
    done

    echo " "


    # Calculate the position of the phrase
    middleLength=$((total_length - phrase_length - 1))  

    # Print the phrase
    for ((i = 0; i < middleLength; i++)); do  
        if [ $i -eq $paddingLength ]; then  
            echo -n -e " ${RED}$phrase${NC} "
        else
            echo -n -e "${GREEN}#${NC}"
        fi
    done
    echo " "

    # Print the bottom row
    for ((i = 0; i < total_length; i++)); do
        echo -n -e "${GREEN}#${NC}"
    done 
    
    echo " "
}
