require "simplecov"
SimpleCov.start

require "./lib/stat_tracker"
require "./lib/game"
require "./lib/team"
require "./lib/game_teams"
require "csv"


RSpec.describe StatTracker do
  before do
    game_path = "./data/games_sampl.csv"
    teams_path = "./data/teams_sampl.csv"
    game_teams_path = "./data/game_teams_sampl.csv"
    locations = {
      games: game_path,
      teams: teams_path,
      game_teams: game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(locations)
  end

  it "exists" do
    expect(@stat_tracker).to be_a(StatTracker)
  end

  it "can calculate the highest total score of all games" do
    expect(@stat_tracker.highest_total_score).to eq(6)
  end

  it "can calculate the lowest total score of all games" do
    expect(@stat_tracker.lowest_total_score).to eq(1)
  end

  it "can calculate the home win percentage" do
    expect(@stat_tracker.percentage_home_wins).to eq(0.54)
  end

  it "can calculate the visitor win percentage" do
    expect(@stat_tracker.percentage_visitor_wins).to eq(0.38)
  end

  it "can calculate the pecentage of games that end up in a tie" do
    expect(@stat_tracker.percentage_ties).to eq(0.08)
  end

  it "can count games in each season" do
    expect(@stat_tracker.count_of_games_by_season).to eq({"20122013"=>11, "20132014"=>2})
  end

  it "can count average goals per game" do
    expect(@stat_tracker.average_goals_per_game).to eq(4.08)
  end

  it "can count average goals by season" do
    expect(@stat_tracker.average_goals_by_season).to eq({"20122013"=>2.05, "20132014"=>2.0})
  end

  it "can count all teams" do
    expect(@stat_tracker.count_of_teams).to eq(16)
  end

  it "can create a hash with offense_helper" do
    expect(@stat_tracker.offense_helper).to be_a Hash
    expect(@stat_tracker.offense_helper.keys.first).to eq("3")
  end

  it "can report team with best offense" do	
    expect(@stat_tracker.best_offense).to eq("New York City FC")
  end

  it "can report team with worst offense" do
    expect(@stat_tracker.worst_offense).to eq("Sporting Kansas City")
  end

  it "can report highest scoring visitor" do	
    expect(@stat_tracker.highest_scoring_visitor).to eq("FC Dallas")
  end

  it "can report the highest scoring home team" do
    expect(@stat_tracker.highest_scoring_home_team).to eq("New York City FC")
  end

  it "can report the lowest scoring visitor" do
    expect(@stat_tracker.lowest_scoring_visitor).to eq("Sporting Kansas City")
  end

  it "can report the lowest scoring home team" do
    expect(@stat_tracker.lowest_scoring_home_team).to eq("Sporting Kansas City")
  end

  it "has a best coach" do
    expect(@stat_tracker.winningest_coach("20122013")).to eq("Claude Julien")
  end

  it "has a worst coach" do
    expect(@stat_tracker.worst_coach("20122013")).to eq("John Tortorella")
  end

  it "has a most accurate team" do
    expect(@stat_tracker.most_accurate_team("20122013")).to eq("FC Dallas")
  end

  it "has a least accurate team" do
    expect(@stat_tracker.least_accurate_team("20122013")).to eq("Sporting Kansas City")
  end

  it "has a team with most tackles" do
    expect(@stat_tracker.most_tackles("20122013")).to eq("FC Dallas")
  end

  it "has a team with fewest tackles" do
    expect(@stat_tracker.fewest_tackles("20122013")).to eq("Sporting Kansas City")
  end
end