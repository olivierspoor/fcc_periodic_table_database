#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
  then
  echo Please provide an element as an argument.
  exit 2
fi

ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements")

for x in $ATOMIC_NUMBER; do
  if [[ $x = $1 ]]; then
    ATOMIC_NUMBER=$1
  fi
done

echo $ATOMIC_NUMBER

