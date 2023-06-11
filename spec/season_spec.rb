require "simplecov"
SimpleCov.start

require "./lib/game"
require "./lib/team"
require "./lib/season"
require "csv"
require "./lib/game_teams"

RSpec.describe Season do
  before do
    game_file = "./data/games_sampl.csv"
    game_team_file = "./data/game_teams_sampl.csv"
    team_data = "./data/teams_sampl.csv"
    @season = Season.new(game_file, game_team_file, "20122013", team_data)
  end

  it "exists" do
    expect(@season).to be_a(Season)
  end

  it "can tell us the season" do
    expect(@season.season).to eq("20122013")
  end

  it "has a series of games" do
    expect(@season.games).to be_an(Array)
    expect(@season.games.length).to eq(11)
    expect(@season.games.sample).to be_a(Game)
  end

  it "has game teams stats" do
    expect(@season.game_teams).to be_an(Array)
    expect(@season.game_teams.sample).to be_a(GameTeam)
  end

  it "can keep track of all game ids" do
    expect(@season.game_ids).to eq(["2012030221", "2012030222", "2012030223", "2012030224", "2012030225", "2012030311", "2012030312", "2012030313", "2012030314", "2012020225", "2012020510"]) 
  end

  it "can track unique team ids" do
    expect(@season.team_ids).to eq(["3", "6", "5"])
  end

  it "has tackle data by team id" do
    expected = {
      "3" => 179,
      "5" => 150,
      "6" => 271
    }
    expect(@season.team_tackles).to eq(expected)
  end

  it "has team accuracy data by team id" do
    expect(@season.team_accuracy).to be_a(Hash)
    expected = {
      "3"=>0.21052631578947367, 
      "5"=>0.0625, 
      "6"=>0.3157894736842105
    }
    expect(@season.team_accuracy).to eq(expected)
  end
end