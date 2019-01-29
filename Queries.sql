1.

Clubs(ID, Name) - Клубы
Teams(ID, ClubID, Name) - Команды. Существует в рамках клуба
Roles(ID, Name) - Роли участников клуба: вратарь, нападающий, тренер

ClubMembers(ID, ClubID, TeamID, RoleID, Name) - Участник клуба
Ограничения (CHECK CONSTRAINT): в клубе 1 тренер, в команде не больше 11 игроков

Championships(ID, Name) - Чемпионаты

Matchs(ID, Name, ChampionshipID) - Матчи.
 Существуют в рамках чемпионата.

MatchTeams(ID, MatchID, TeamID, Goals)
Ограничения (CHECK CONSTRAINT): в матче может быть две команды от разных клубов

-----------------------------------------------------
2.

DECLARE @MatchID int;
SET @MatchID = 1;

SELECT [ID]
      ,[Name]
      ,[ClubID]
      ,[TeamID]
      ,[RoleID]
  FROM [SoccerMatches].[dbo].[ClubMembers] CM
  WHERE CM.TeamID IN 
  (
	SELECT [TeamID]
  FROM [SoccerMatches].[dbo].[MatchTeams] MT 
  WHERE MT.MatchID = @MatchID
  )
-----------------------------------------------------------
3.

DECLARE @ChampionshipID int;
SET @ChampionshipID = 1;



SELECT 
	  C.ID ClubID
	  ,C.Name ClubName
	  ,SUM(MT.[Goals]) TotalGoals
  FROM [SoccerMatches].[dbo].[MatchTeams] MT
  LEFT JOIN [SoccerMatches].[dbo].[Teams] T ON T.ID = MT.TeamID
  LEFT JOIN [SoccerMatches].[dbo].[Clubs] C ON C.ID = T.ClubID
  WHERE MT.MatchID IN
  (
  SELECT [ID] FROM [SoccerMatches].[dbo].[Matchs]
  )
  GROUP BY C.ID, C.Name

  ---------------------------------------------------------------------
4.

DECLARE @ChampionshipID int;
SET @ChampionshipID = 1;



SELECT TOP 3 
	  C.ID ClubID
	  ,C.Name ClubName
	  ,SUM(MT.[Goals]) TotalGoals
  FROM [SoccerMatches].[dbo].[MatchTeams] MT
  LEFT JOIN [SoccerMatches].[dbo].[Teams] T ON T.ID = MT.TeamID
  LEFT JOIN [SoccerMatches].[dbo].[Clubs] C ON C.ID = T.ClubID
  WHERE MT.MatchID IN
  (
  SELECT [ID] FROM [SoccerMatches].[dbo].[Matchs]
  )
  GROUP BY C.ID, C.Name
  ORDER BY  SUM(MT.[Goals]) DESC
  -----------------------------------------------------------
5.

DECLARE @ChampionshipID int;
SET @ChampionshipID = 1;

     ; WITH CTE AS (
 SELECT 
MT.[ID]
      ,MT.[MatchID]
      ,MT.[TeamID]
	  ,T.Name


	  ,C.ID ClubID
	  ,C.Name ClubName
	  ,MT.[Goals] 
	  ,ROW_NUMBER() OVER (PARTITION BY MT.[MatchID]  ORDER BY MT.[Goals] ASC) SortNumberASC
	  ,ROW_NUMBER() OVER (PARTITION BY MT.[MatchID]  ORDER BY MT.[Goals] DESC) SortNumberDESC
	  
  FROM [SoccerMatches].[dbo].[MatchTeams] MT
  LEFT JOIN [SoccerMatches].[dbo].[Teams] T ON T.ID = MT.TeamID
  LEFT JOIN [SoccerMatches].[dbo].[Clubs] C ON C.ID = T.ClubID
  WHERE MT.MatchID IN
  (
  SELECT [ID] FROM [SoccerMatches].[dbo].[Matchs]
  )
  )

SELECT TOP 3 CTE.ClubID
 ,SUM(CASE   
      WHEN SortNumberASC = SortNumberDESC THEN 1  
      ELSE 3 
   END) PointsTotal
FROM cte WHERE SortNumberDESC = 1 	
GROUP BY cte.ClubID
ORDER BY PointsTotal DESC


