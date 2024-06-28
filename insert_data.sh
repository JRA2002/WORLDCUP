#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

cat games.csv | while IFS=',' read YEAR ROUND WINNER OPPONENT WG OG
do
  if [[ $YEAR != 'year' ]]
  then
    #insert winner teams
    echo "$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")"
    #insert opponent teams
    echo "$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")"
  fi
done
cat games.csv | while IFS=',' read YEAR ROUND WINNER OPPONENT WG OG
do 
  if [[ $YEAR != 'year' ]]
  then
    #get team id
    TEAM_ID_WIN=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    TEAM_ID_OPPO=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
    echo "$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR,'$ROUND',$TEAM_ID_WIN,$TEAM_ID_OPPO,$WG,$OG)")"
  fi
done

