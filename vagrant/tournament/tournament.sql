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

CREATE TABLE Players (id SERIAL PRIMARY KEY, name TEXT, wins INTEGER DEFAULT 0, matches INTEGER DEFAULT 0);

CREATE TABLE Matches (id SERIAL PRIMARY KEY, player1 INT REFERENCES Players (id), player2 INT REFERENCES Players (id));
