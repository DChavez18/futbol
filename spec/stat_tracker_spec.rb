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

  it "can calculate the highest total score of games" do
    expect(@stat_tracker_1.highest_total_score).to eq(6)
  end
end