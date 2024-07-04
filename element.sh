#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
  then
  echo Please provide an element as an argument.
  exit 2
fi

GOT_ATOMIC_NUMBER() {
  echo $ATOMIC_NUMBER
  exit 0
}

GOT_SYMBOL() {
  echo $SYMBOL
  exit 0
}

GOT_NAME() {
  echo $NAME
  exit 0
}

ATOMIC_NUMBER_LIST=$($PSQL "SELECT atomic_number FROM elements")

for x in $ATOMIC_NUMBER_LIST; do
  if [[ $x = $1 ]]; then
    ATOMIC_NUMBER=$1
    GOT_ATOMIC_NUMBER
  fi
done

if [[ -z $ATOMIC_NUMBER ]]
  then
  SYMBOL_LIST=$($PSQL "SELECT symbol FROM elements")

  for x in $SYMBOL_LIST; do
    if [[ $x = $1 ]]; then
      SYMBOL=$1
      GOT_SYMBOL
    fi
  done
fi

if [[ -z $SYMBOL ]]
  then
  NAME_LIST=$($PSQL "SELECT name FROM elements")

  for x in $NAME_LIST; do
    if [[ $x = $1 ]]; then
      NAME=$1
      GOT_NAME
    fi
  done
fi

echo "I could not find that element in the database."