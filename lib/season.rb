require "csv"

class Season
  attr_reader :games,
              :season,
              :game_teams,
              :game_ids,
              :team_ids,
              :teams,
              :team_tackles

  def initialize(game_file, game_team_file, season, team_data)
    @season = season
    @games = generate_games(game_file)
    @game_ids = generate_game_ids
    @game_teams = generate_game_teams(game_team_file)
    @team_ids = generate_team_ids
    @teams = generate_teams(team_data)
    @team_tackles = generate_tackle_data
  end

  def generate_games(game_file)
    games = []
    game_lines = CSV.open game_file, headers: true, header_converters: :symbol
    game_lines.each do |line|
      if line[:season] == @season
        games << Game.new(line)
      end
    end
    @games = games
  end

  def generate_game_ids
    game_ids = []
    @games.each do |game|
      game_ids << game.game_id
    end
    @game_ids = game_ids
  end
  
  def generate_game_teams(game_team_file)
    game_teams = []
    game_lines = CSV.open game_team_file, headers: true, header_converters: :symbol
    game_lines.each do |line|
      game_teams << GameTeam.new(line) if @game_ids.include?(line[:game_id])
    end
    @game_teams = game_teams
  end
      
  def generate_team_ids
    team_ids = []
    @games.each do |game|
      team_ids << game.home_team_id
      team_ids << game.away_team_id
    end
    @team_ids = team_ids.uniq
  end

  def generate_teams(team_data)
    teams = []
    game_lines = CSV.open team_data, headers: true, header_converters: :symbol
    game_lines.each do |line|
      if !@team_ids.include?(line[:team_id])
        teams << Team.new(line)
      end
    end
    @teams = teams
  end

  def generate_tackle_data
    team_tackles = Hash.new(0)
    @game_teams.each do |game_team|
      team_id = game_team.team_id
      tackles = game_team.tackles
      team_tackles[team_id] += tackles
    end
    @team_tackles = team_tackles
  end
end