require 'bundler'
Bundler.require

require_relative 'lib/player'
require_relative 'lib/game'

jose = Player.new("jose")
josiane = Player.new("josiane")

while jose.life_points > 0 && josiane.life_points > 0
    #rencontre des joueurs et affiche etat
    puts "      etat des 2 joueurs : "
    jose.show_state
    josiane.show_state
    puts "---------------------------"

    #on les fait attaquer chaqu un son tour
    puts "      phase d attaque : "
    jose.attacks(josiane)
    break if josiane.life_points == 0
    josiane.attacks(jose)
    puts "---------------------------"
end