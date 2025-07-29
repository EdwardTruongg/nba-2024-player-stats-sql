SELECT * 
FROM PlayerStats;


-- Top 10 Scorers (Points Per Game)
-- Includes '2TM' rows for traded players to show full-season stats
-- Excludes team-specific rows to avoid duplicates
-- Ensures each player appears only once with complete scoring average
SELECT TOP 10 
			Player, 
			Age,
			Team, 
			G, 
			ROUND(PTS,2) AS PointsPerGame
FROM PlayerStats
WHERE Team = '2TM' 
				OR Player NOT IN (SELECT Player FROM PlayerStats WHERE Team = '2TM')
ORDER BY PTS DESC;


-- Most Efficient 3-Point Shooters
-- Filters for players attempting at least 4 threes per game
-- Ranks by 3-point percentage to highlight high-volume, high-efficiency shooters
SELECT Player,
		Team,
		Pos,
		G,
		Round(_3PA,2) AS ThreePointAttepmtPerGame,
		Round(_3P1,3) AS ThreePointPercentagePerGame
FROM PlayerStats
WHERE _3PA >= 4 
ORDER BY ThreePointPercentagePerGame DESC;


-- Players Who Averaged a Double-Double
-- Selects players with exactly two stat categories averaging 10+ per game
-- Uses CASE logic to count qualifying categories across points, rebounds, assists, blocks, and steals
-- Filters for true double-double averages (not triple-doubles or more)
SELECT Player,
       Team,
       Pos,
	   G,
       ROUND(PTS, 2) AS PointsPerGame,
       ROUND(AST, 2) AS AssistsPerGame,
       ROUND(TRB, 2) AS ReboundsPerGame,
       ROUND(BLK, 2) AS BlocksPerGame,
       ROUND(STL, 2) AS StealsPerGame
FROM PlayerStats
WHERE (
    CASE WHEN PTS >= 10 THEN 1 ELSE 0 END +
    CASE WHEN AST >= 10 THEN 1 ELSE 0 END +
    CASE WHEN TRB >= 10 THEN 1 ELSE 0 END +
    CASE WHEN BLK >= 10 THEN 1 ELSE 0 END +
    CASE WHEN STL >= 10 THEN 1 ELSE 0 END
) = 2
ORDER BY PointsPerGame Desc;


-- Players averaging 25+ PPG but shooting under 45% FG
-- Highlights high scorers who may be inefficient shooters
SELECT Player,
		Team,
		Pos,
		G,
		ROUND(PTS,2) AS PointsPerGame,
		ROUND(FG1,3) AS FieldGoalPercentage
FROM PlayerStats
WHERE (PTS >= 25 AND FG1 <= 0.45)
ORDER BY PointsPerGame DESC;


-- Non-Point Guards with a Point Guard Profile
-- Finds players averaging 6+ assists and ? 4 turnovers per game
-- Excludes players listed as PG to highlight secondary playmakers
SELECT Player,
		Team,
		Pos,
		G,
		ROUND(AST,2) AS AssistsPerGame,
		ROUND(TOV,2) AS TurnoversPerGame
FROM PlayerStats
WHERE AST >= 6 
		AND TOV <= 4 
		AND Pos <> 'PG'
ORDER BY AssistsPerGame DESC;


-- Team with the Most 20+ PPG Scorers
-- Counts how many players on each team average 20 or more points per game
-- Excludes '2TM' rows to prevent double-counting traded players
-- Ranks teams by number of high scorers
SELECT Team,
	COUNT(Player) AS NumberPlayersAverage20 
FROM PlayerStats
WHERE PTS >= 20 
		AND Team <> '2TM'
GROUP BY Team
ORDER BY NumberPlayersAverage20 DESC


-- Most Balanced Stat Lines
-- Finds players averaging at least 5 points, 5 assists, and 5 rebounds per game
-- Uses CASE logic to ensure all three categories meet the threshold
-- Highlights well-rounded contributors across multiple areas
SELECT Player,
		Team,
		POS,
		G,
		ROUND(PTS,2) AS PointsPerGame,
		ROUND(AST,2) AS AssistsPerGame,
		ROUND(TRB,2) AS ReboundsPerGame
FROM PlayerStats
WHERE (
    CASE WHEN PTS >= 5 THEN 1 ELSE 0 END +
    CASE WHEN AST >= 5 THEN 1 ELSE 0 END +
    CASE WHEN TRB >= 5 THEN 1 ELSE 0 END 
) >= 3
ORDER BY PointsPerGame Desc;


-- All-Defensive Team Candidates
-- Filters for players averaging at least 1.5 steals and 1.0 blocks per game
-- Highlights strong two-way defenders based on key defensive stats
SELECT Player,
		Age,
		Pos,
		Team,
		G,
		ROUND(STL,2) AS StealsPerGame,
		ROUND(BLK,2) AS BlocksPerGame
FROM PlayerStats
WHERE STL >= 1.5
		AND BLK >= 1
ORDER BY StealsPerGame DESC;


-- Playmaking Big Men
-- Finds centers and power forwards averaging 5 or more assists per game
-- Highlights frontcourt players with strong passing and playmaking roles
SELECT Player,
		Age,
		Pos,
		Team,
		G,
		ROUND(AST,2) AS AssistsPerGame
FROM PlayerStats
WHERE (Pos = 'C' OR Pos = 'PF')
			AND AST >= 5 
ORDER BY AssistsPerGame DESC;


-- Pre- and Post-Trade Performance Comparison
-- Selects only players who were traded (i.e., have a '2TM' row)
-- Excludes the combined '2TM' row to focus on team-specific performance
-- Enables comparison of key stats before and after the trade
SELECT Player,
		Team,
		POS,
		G,
		ROUND(MP,2) AS MinutesPlayed,
		ROUND(FG1,2) AS FieldGoalPercentage,
		ROUND(AST,2) AS AssistsPerGame,
		ROUND(STL,2) AS StealsPerGame,
		ROUND(BLK,2) AS BlocksPerGame,
		ROUND(TOV,2) AS TurnoversPerGame,
		ROUND(PTS,2) AS PointsPerGame
FROM PlayerStats
WHERE Player IN (SELECT Player FROM PlayerStats WHERE Team = '2TM')	
			AND Team <> '2TM'
ORDER BY Player;
