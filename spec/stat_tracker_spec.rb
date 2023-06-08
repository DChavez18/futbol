require "./lib/stat_tracker"
require "./lib/game"
require "./lib/team"
require "csv"


RSpec.describe StatTracker do
  before do
    game_path = './data/games_sampl.csv'
    teams_path = './data/teams_sampl.csv'
    game_teams_path = './data/game_teams_sampl.csv'
    @stat_tracker_1 = StatTracker.from_csv(game_path, teams_path, game_teams_path)
  end

  it "exists" do
    expect(@stat_tracker_1).to be_a(StatTracker)
  end

  it "can calculate the highest total score of all games" do
    expect(@stat_tracker_1.highest_total_score).to eq(6)
  end

  it "can calculate the lowest total score of all games" do
    expect(@stat_tracker_1.lowest_total_score).to eq(1)
  end

  it "can calculate the home win percentage" do
    expect(@stat_tracker_1.percentage_home_wins).to eq(54)
  end

  it "can calculate the visitor win percentage" do
    expect(@stat_tracker_1.pecentage_visitor_wins).to be_a Float
  end
end