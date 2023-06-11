require "csv"

class Season
  attr_reader :games,
              :season,
              :game_teams,
              :game_ids,
              :team_ids,
              :team_tackles,
              :team_accuracy

  def initialize(game_file, game_team_file, season, team_data)
    @season = season
    @games = generate_games(game_file)
    @game_ids = generate_game_ids
    @game_teams = generate_game_teams(game_team_file)
    @team_ids = generate_team_ids
    @team_tackles = generate_tackle_data
    @team_accuracy = generate_accuracy_data
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
    game_teams_lines = CSV.open game_team_file, headers: true, header_converters: :symbol
    game_teams_lines.each do |line|
      if @game_ids.include?(line[:game_id])
        game_teams << GameTeam.new(line)
      end
    end
    @game_teams = game_teams
  end
      
  def generate_team_ids
    team_ids = []
    @game_teams.each do |game|
      team_ids << game.team_id
    end
    @team_ids = team_ids.uniq
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

  def generate_accuracy_data
    team_games = @game_teams.group_by { |game_team| game_team.team_id }
    team_accuracy = {}
    team_games.each do |team_id, games|
      shots = games.map { |game| game.shots }
      goals = games.map { |game| game.goals }
      accuracy = goals.sum / shots.sum.to_f
      team_accuracy[team_id] = accuracy
    end
    @team_accuracy = team_accuracy
  end
end