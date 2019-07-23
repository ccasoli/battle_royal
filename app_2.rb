require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

#acceuil
puts "--------------------------"
puts "      BATTLE ROYAL        "
puts "--------------------------"

#le joueur choisi un pseudo
print "choisie un pseudo : "
input_name = gets.chomp
#initialise le joueur humain
player1 = HumanPlayer.new(input_name)

#inisialise mes IA
jose = Player.new("jose")
josiane = Player.new("josiane")
ennemies = [jose, josiane]

binding pry

#le combat commence ici
while player1.life_points > 0 && (jose.life_points > 0 || josiane.life_points > 0)
    #menu
    player1.show_state
    puts "--------------------------"
    puts "quel action veut tu faire ?"
    puts ""
    puts "a - chercher une meilleure arme"
    puts "s - chercher a se soigner"
    puts ""
    puts "attaquer un joueur en vue : "
    print "0- "
    jose.show_state
    print "1- "
    josiane.show_state
    #saisi action
    puts "--------------------------"
    print "tu choisi : "
    input_action = gets.chomp
    puts "--------------------------"
    while input_action != "a" && input_action != "s" && input_action != "0" && input_action != "1"
        puts "choisir selon menu : "
        input_action = gets.chomp
    end
    if input_action == "a"
        player1.search_weapon
    elsif input_action == "s"
        player1.search_health_pack
    elsif input_action == "0"
        player1.attacks(jose)
    elsif input_action == "1"
        player1.attacks(josiane)
    end
    ennemies.each do |e|
        if player1.life_points <= 0
            player1.life_points = 0
            break
        end
        e.attacks(player1)
    end
end
puts "la partie est termine"
if player1.life_points == 0
    puts "tu as perdu" 
else 
    puts "tu as gagne"
end