#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
  then
  echo Please provide an element as an argument.
  exit 0 # error code 0 necessary for fcc task
fi

GOT_ATOMIC_NUMBER() {
  ATOMIC_RESULT=$($PSQL "SELECT name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius  FROM elements LEFT JOIN properties USING(atomic_number) LEFT JOIN types USING(type_id) WHERE atomic_number=$ATOMIC_NUMBER")
  echo $ATOMIC_RESULT | while IFS="|" read NAME SYMBOL TYPE ATOMIC_MASS MELTING_POINT BOILING_POINT
  do
    echo -e "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  done
  exit 0
}

GOT_SYMBOL() {
  SYMBOL_RESULT=$($PSQL "SELECT atomic_number, name, type, atomic_mass, melting_point_celsius, boiling_point_celsius  FROM elements LEFT JOIN properties USING(atomic_number) LEFT JOIN types USING(type_id) WHERE symbol='$SYMBOL'")
  echo $SYMBOL_RESULT | while IFS="|" read ATOMIC_NUMBER NAME TYPE ATOMIC_MASS MELTING_POINT BOILING_POINT
  do
    echo -e "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  done
  exit 0
}

GOT_NAME() {
  NAME_RESULT=$($PSQL "SELECT atomic_number, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius  FROM elements LEFT JOIN properties USING(atomic_number) LEFT JOIN types USING(type_id) WHERE name='$NAME'")
  echo $NAME_RESULT | while IFS="|" read ATOMIC_NUMBER SYMBOL TYPE ATOMIC_MASS MELTING_POINT BOILING_POINT
  do
    echo -e "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  done
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