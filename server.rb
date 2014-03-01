require 'pry'
require 'sinatra'

scoreboard =
[
  {
    home_team: "Patriots",
    away_team: "Broncos",
    home_score: 7,
    away_score: 3
  },
  {
    home_team: "Broncos",
    away_team: "Colts",
    home_score: 3,
    away_score: 0
  },
  {
    home_team: "Patriots",
    away_team: "Colts",
    home_score: 11,
    away_score: 7
  },
  {
    home_team: "Steelers",
    away_team: "Patriots",
    home_score: 7,
    away_score: 21
  }
]

def leaderboard(scoreboard)
leaderboard = {}
scoreboard.each do |hash|
  leaderboard.store(hash[:home_team], {wins: 0,losses: 0})
  leaderboard.store(hash[:away_team], {wins: 0,losses: 0})
end
scoreboard.each do |hash|
    if hash[:home_score] > hash[:away_score]
      leaderboard[hash[:home_team]][:wins] += 1
      leaderboard[hash[:away_team]][:losses] += 1
    else
      leaderboard[hash[:home_team]][:losses] += 1
      leaderboard[hash[:away_team]][:wins] += 1
  end
end
leaderboard.each do |key, value|
  value[:percent] =  value[:wins]/(value[:wins]+value[:losses]).to_f
end
leaderboard.sort_by { |key,value| value[:percent]}
return leaderboard
end


get '/leaderboard' do
  @leaderboard = leaderboard(scoreboard)
  erb :leader
end


#{"Patriots"=>{:wins=>3, :losses=>0, :percent=>1.0}, "Broncos"=>{:wins=>1, :losses=>1, :percent=>0.5}, "Colts"=>{:wins=>0, :losses=>2, :percent=>0.0}, "Steelers"=>{:wins=>0, :losses=>1, :percent=>0.0}}
