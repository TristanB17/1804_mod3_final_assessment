require 'rails_helper'

describe "GET /api/v1/games/1" do
  it 'displays the game id and each players id and score' do
    josh = User.create(id: 1, name: "Josh")
    sal = User.create(id: 2, name: "Sal")

    game = Game.create(player_1: josh, player_2: sal)

    josh.plays.create(game: game, word: "sal", score: 3)
    josh.plays.create(game: game, word: "zoo", score: 12)
    sal.plays.create(game: game, word: "josh", score: 14)
    sal.plays.create(game: game, word: "no", score: 2)
    expected = { 'game_id' => game.id, 'scores' => [{'user_id' => josh.id, 'score' => 15}, {'user_id' => sal.id, 'score' => 16}]}
    get "/api/v1/games/#{game.id}"

    expect(JSON.parse(response.body)).to eq(expected)
  end
end
