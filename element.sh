#!/bin/bash

# Script to report periodic table element data

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1  ]]
  then
    echo "Please provide an element as an argument."
    
elif [[ $1 =~ ^[0-9]+$  ]]
  then
    ATOMIC_NUMBER=$1
    ELEMENT_INFO=$($PSQL "SELECT symbol, name, atomic_mass, melting_point_celsius, boiling_point_celsius, type FROM elements 
    JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE atomic_number=$ATOMIC_NUMBER")

    if [[  -z $ELEMENT_INFO  ]]
    then
      echo "I could not find that element in the database."
    else
      echo $ELEMENT_INFO | while IFS="|" read SYMBOL NAME ATOMIC_MASS MELTING_POINT_CELSIUS BOILING_POINT_CELSIUS TYPE
      do
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting"\
        "point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
      done
    fi

else
  VAR=$1
  LENGTH=${#VAR}

  if [[  $LENGTH -gt 2  ]]
  then
    NAME=$1

    ELEMENT_INFO=$($PSQL "SELECT atomic_number, symbol, atomic_mass, melting_point_celsius, boiling_point_celsius, type FROM elements 
    JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE name='$NAME'")

    if [[  -z $ELEMENT_INFO  ]]
    then
      echo "I could not find that element in the database."
    else
      echo $ELEMENT_INFO | while IFS="|" read ATOMIC_NUMBER SYMBOL ATOMIC_MASS MELTING_POINT_CELSIUS BOILING_POINT_CELSIUS TYPE
      do
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting"\
        "point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
      done
    fi

  else
    SYMBOL=$1
    ELEMENT_INFO=$($PSQL "SELECT atomic_number, name, atomic_mass, melting_point_celsius, boiling_point_celsius, type FROM elements 
    JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE symbol='$SYMBOL'")

    if [[  -z $ELEMENT_INFO  ]]
    then
      echo "I could not find that element in the database."
    else
      echo $ELEMENT_INFO | while IFS="|" read ATOMIC_NUMBER NAME ATOMIC_MASS MELTING_POINT_CELSIUS BOILING_POINT_CELSIUS TYPE
      do
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting"\
        "point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
      done
    fi
  fi
fi
    


