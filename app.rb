require 'bundler'
Bundler.require

require_relative 'lib/player'
require_relative 'lib/game'

pierre = Player.new("pierre")
clement = Player.new("clement")

while pierre.life_points > 0 && clement.life_points > 0
    #rencontre des joueurs et affiche etat
    puts "      etat des 2 joueurs : "
    pierre.show_state
    clement.show_state
    puts "---------------------------"

    #on les fait attaquer chaqu un son tour
    puts "      phase d attaque : "
    pierre.attacks(clement)
    break if clement.life_points == 0
    clement.attacks(pierre)
    puts "---------------------------"
end

binding pry