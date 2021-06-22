#!/bin/sh

echo "Organizations Name [ENTER]:"
read orgInput
FINISHED="false"

while [$FINISHED == "false"]
 do
  if [$orgInput]; then
    shopt -s globstar
    rename -n 's/org/$orgInput/' **
    FINISHED="true"
  else
    echo "Please enter in an organization name or hit [CTR+c] to stop"
done
printf "\n"
