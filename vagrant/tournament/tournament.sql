-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

DROP DATABASE IF EXISTS tournament;

CREATE DATABASE tournament;
\c tournament;

CREATE TABLE Players (id SERIAL PRIMARY KEY, name TEXT);

CREATE TABLE Matches (id SERIAL PRIMARY KEY, winner INT REFERENCES Players (id), loser INT REFERENCES Players (id));

-- view for joining tables Players and Matches to count the number of wins for each player
-- left join is used to also include those players who have not yet won any matches
CREATE VIEW countWins AS
    SELECT Players.id, Players.name, COUNT(Matches.winner) AS wins
    FROM Players LEFT JOIN Matches
    ON Players.id = Matches.winner
    GROUP BY Players.id;

-- view for joining tables Players and Matches to count the number of matches played for each player
-- left join is used to also include those players who have not yet played any matches
CREATE VIEW countMatches AS
    SELECT Players.id, Players.name, COUNT(Matches) AS matches
    FROM Players LEFT JOIN Matches
    ON Players.id = Matches.winner OR Players.id = Matches.loser
    GROUP BY Players.id;

-- view joining views countWins and countMatches to summarize the wins and matches played record for each player
CREATE VIEW standings AS
    SELECT countWins.id, countWins.name, countWins.wins, countMatches.matches
    FROM countWins JOIN countMatches
    ON countWins.id = countMatches.id
    ORDER BY countWins.wins DESC;
