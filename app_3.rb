require 'bundler'
Bundler.require

require_relative 'lib/player'
require_relative 'lib/game'

gameone = Game.new("wolverine")
i = 1
while gameone.is_still_ongoing?
    puts "          tour#{i}"
    gameone.show_players
    gameone.new_players_in_sight
    gameone.ennemies_attack
    break if gameone.is_still_ongoing? == false
    gameone.menu
    gameone.menu_choice
    i+=1
end
gameone.end