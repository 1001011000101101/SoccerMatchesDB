USE [master]
GO
/****** Object:  Database [SoccerMatches]    Script Date: 29.01.2019 10:46:28 ******/
CREATE DATABASE [SoccerMatches]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SoccerMatches', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\SoccerMatches.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'SoccerMatches_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\SoccerMatches_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [SoccerMatches] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SoccerMatches].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SoccerMatches] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SoccerMatches] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SoccerMatches] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SoccerMatches] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SoccerMatches] SET ARITHABORT OFF 
GO
ALTER DATABASE [SoccerMatches] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SoccerMatches] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SoccerMatches] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SoccerMatches] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SoccerMatches] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SoccerMatches] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SoccerMatches] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SoccerMatches] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SoccerMatches] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SoccerMatches] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SoccerMatches] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SoccerMatches] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SoccerMatches] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SoccerMatches] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SoccerMatches] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SoccerMatches] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SoccerMatches] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SoccerMatches] SET RECOVERY FULL 
GO
ALTER DATABASE [SoccerMatches] SET  MULTI_USER 
GO
ALTER DATABASE [SoccerMatches] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SoccerMatches] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SoccerMatches] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SoccerMatches] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [SoccerMatches] SET DELAYED_DURABILITY = DISABLED 
GO
USE [SoccerMatches]
GO
/****** Object:  UserDefinedFunction [dbo].[IsValidClub]    Script Date: 29.01.2019 10:46:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[IsValidClub] 
(
	@ClubID int
)
RETURNS BIT
AS
BEGIN
	DECLARE @IsValid BIT
	DECLARE @CountOfCaptains INT
	DECLARE @CaptainRoleID INT
	SET @IsValid = 0
	SET @CaptainRoleID = 5


	SELECT @CountOfCaptains = COUNT(*) FROM ClubMembers CM WHERE CM.ClubID = @ClubID AND CM.RoleID = @CaptainRoleID

	IF @CountOfCaptains = 1
		SET @IsValid = 1

	RETURN @IsValid

END

GO
/****** Object:  UserDefinedFunction [dbo].[IsValidTeam]    Script Date: 29.01.2019 10:46:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[IsValidTeam] 
(
	@TeamID int
)
RETURNS BIT
AS
BEGIN
	DECLARE @IsValid BIT
	DECLARE @CountOfPlayers INT
	DECLARE @CaptainRoleID INT
	SET @IsValid = 0
	SET @CaptainRoleID = 5


	SELECT @CountOfPlayers = COUNT(*) FROM ClubMembers CM WHERE CM.TeamID = @TeamID AND CM.RoleID != @CaptainRoleID

	IF @CountOfPlayers <= 11
		SET @IsValid = 1

	RETURN @IsValid

END


GO
/****** Object:  Table [dbo].[Championships]    Script Date: 29.01.2019 10:46:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Championships](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nchar](100) NOT NULL,
 CONSTRAINT [PK_Championships] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ClubMembers]    Script Date: 29.01.2019 10:46:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClubMembers](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nchar](100) NOT NULL,
	[ClubID] [int] NULL,
	[TeamID] [int] NULL,
	[RoleID] [int] NULL,
 CONSTRAINT [PK_ClubMembers] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Clubs]    Script Date: 29.01.2019 10:46:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clubs](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nchar](100) NOT NULL,
 CONSTRAINT [PK_Clubs] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Matchs]    Script Date: 29.01.2019 10:46:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Matchs](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nchar](100) NOT NULL,
	[ChampionshipID] [int] NULL,
 CONSTRAINT [PK_Matchs] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MatchTeams]    Script Date: 29.01.2019 10:46:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MatchTeams](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Goals] [int] NULL,
	[MatchID] [int] NULL,
	[TeamID] [int] NULL,
 CONSTRAINT [PK_MatchTeams] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Roles]    Script Date: 29.01.2019 10:46:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nchar](100) NOT NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Teams]    Script Date: 29.01.2019 10:46:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Teams](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ClubID] [int] NOT NULL,
	[Name] [nchar](100) NOT NULL,
 CONSTRAINT [PK_Teams] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[ClubMembers]  WITH CHECK ADD  CONSTRAINT [FK_ClubMembers_Clubs] FOREIGN KEY([ClubID])
REFERENCES [dbo].[Clubs] ([ID])
GO
ALTER TABLE [dbo].[ClubMembers] CHECK CONSTRAINT [FK_ClubMembers_Clubs]
GO
ALTER TABLE [dbo].[ClubMembers]  WITH CHECK ADD  CONSTRAINT [FK_ClubMembers_Roles] FOREIGN KEY([RoleID])
REFERENCES [dbo].[Roles] ([ID])
GO
ALTER TABLE [dbo].[ClubMembers] CHECK CONSTRAINT [FK_ClubMembers_Roles]
GO
ALTER TABLE [dbo].[ClubMembers]  WITH CHECK ADD  CONSTRAINT [FK_ClubMembers_Teams] FOREIGN KEY([TeamID])
REFERENCES [dbo].[Teams] ([ID])
GO
ALTER TABLE [dbo].[ClubMembers] CHECK CONSTRAINT [FK_ClubMembers_Teams]
GO
ALTER TABLE [dbo].[Matchs]  WITH CHECK ADD  CONSTRAINT [FK_Matchs_Championships] FOREIGN KEY([ChampionshipID])
REFERENCES [dbo].[Championships] ([ID])
GO
ALTER TABLE [dbo].[Matchs] CHECK CONSTRAINT [FK_Matchs_Championships]
GO
ALTER TABLE [dbo].[MatchTeams]  WITH CHECK ADD  CONSTRAINT [FK_MatchTeams_Matchs] FOREIGN KEY([MatchID])
REFERENCES [dbo].[Matchs] ([ID])
GO
ALTER TABLE [dbo].[MatchTeams] CHECK CONSTRAINT [FK_MatchTeams_Matchs]
GO
ALTER TABLE [dbo].[MatchTeams]  WITH CHECK ADD  CONSTRAINT [FK_MatchTeams_Teams] FOREIGN KEY([TeamID])
REFERENCES [dbo].[Teams] ([ID])
GO
ALTER TABLE [dbo].[MatchTeams] CHECK CONSTRAINT [FK_MatchTeams_Teams]
GO
ALTER TABLE [dbo].[Teams]  WITH CHECK ADD  CONSTRAINT [FK_Teams_Teams] FOREIGN KEY([ClubID])
REFERENCES [dbo].[Clubs] ([ID])
GO
ALTER TABLE [dbo].[Teams] CHECK CONSTRAINT [FK_Teams_Teams]
GO
ALTER TABLE [dbo].[ClubMembers]  WITH CHECK ADD  CONSTRAINT [CK_ClubMembersCaptain] CHECK  (([dbo].[IsValidClub]([ClubID])=(1)))
GO
ALTER TABLE [dbo].[ClubMembers] CHECK CONSTRAINT [CK_ClubMembersCaptain]
GO
ALTER TABLE [dbo].[ClubMembers]  WITH CHECK ADD  CONSTRAINT [CK_ClubMembersPlayers] CHECK  (([dbo].[IsValidTeam]([TeamID])=(1)))
GO
ALTER TABLE [dbo].[ClubMembers] CHECK CONSTRAINT [CK_ClubMembersPlayers]
GO
/****** Object:  StoredProcedure [dbo].[AddMatch]    Script Date: 29.01.2019 10:46:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AddMatch] 
	-- Add the parameters for the stored procedure here
	@ChampionshipID int, 
	@Name nvarchar(100),
	@TeamIDFirst int,
	@TeamIDSecond int
AS
BEGIN
	DECLARE @ClubIDFirst int;
	DECLARE @ClubIDSecond int;
	DECLARE @MatchID int;

	DECLARE @Inserted table(ID int);

	SELECT @ClubIDFirst = T.ClubID FROM Teams T WHERE T.ID = @TeamIDFirst
	SELECT @ClubIDSecond = T.ClubID FROM Teams T WHERE T.ID = @TeamIDSecond

	IF (@ClubIDFirst != @ClubIDSecond)
	BEGIN

		BEGIN TRY
			BEGIN TRAN
				INSERT [dbo].[Matchs]
				OUTPUT INSERTED.ID
				INTO @Inserted
				VALUES (@Name ,@ChampionshipID);

				SELECT @MatchID = I.ID FROM @Inserted I

				INSERT INTO [dbo].[MatchTeams] ([Goals] ,[MatchID] ,[TeamID]) VALUES (0 ,@MatchID , @TeamIDFirst);
				INSERT INTO [dbo].[MatchTeams] ([Goals] ,[MatchID] ,[TeamID]) VALUES (0 ,@MatchID , @TeamIDSecond);
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			ROLLBACK TRAN
		END CATCH

	END;



	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT I.ID FROM @Inserted I
END

GO
USE [master]
GO
ALTER DATABASE [SoccerMatches] SET  READ_WRITE 
GO
