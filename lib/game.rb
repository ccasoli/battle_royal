#class Game init avec 1 HumanPlayer et des Player
class Game
    attr_accessor :human_player, :ennemies_in_sight, :players_left

    def initialize(human_player)
        @players_left = 10
        @human_player = HumanPlayer.new(human_player)
        @ennemies_in_sight = []
    end

    #permet de sortir un Player du tableau ennemies
    def kill_player(remove_player)
        @ennemies_in_sight.delete_at(remove_player)
    end

    #return true si wolverine est en vie et qu il n a pas tue tout le monde
    def is_still_ongoing?
        @human_player.life_points > 0 && @players_left > 0
    end

    #affiche le joueur
    def show_players
        puts "-----------------------------------"
        puts "#{@human_player.name} a #{@human_player.life_points} point de vie"
    end
    
    #affiche le menu et tout les ennemies possible a attaquer
    def menu
        puts "--------------------------"
        puts "quel action veut tu faire ?"
        puts ""
        puts "a - chercher une meilleure arme"
        puts "s - essyer de se soigner"
        puts ""
        puts "attaquer un ennemie en vue #{@ennemies_in_sight.length} restants"
        i = 0
        @ennemies_in_sight.each do |e| 
            print "#{i}- "
            e.show_state
            i+=1
            break if is_still_ongoing? == false
        end 
    end

    #permet de faire un choix par rapport au menu 
    def menu_choice
        #saisi action
        puts "--------------------------"
        print "tu choisi : "
        input_action = gets.chomp
        puts "--------------------------"
        while input_action != "a" && input_action != "s" && input_action.to_i < 0 && input_action.to_i > @ennemies.length
            print "choisir selon menu : "
            input_action = gets.chomp
            puts "--------------------------"
        end
        if input_action == "a"
            @human_player.search_weapon
        elsif input_action == "s"
            @human_player.search_health_pack
        else
            @human_player.attacks(@ennemies_in_sight[input_action.to_i])
            kill_player(input_action.to_i) if @ennemies_in_sight[input_action.to_i].life_points <= 0
        end
    end

    #ajoute des nouveaux joueur en vue
    def new_players_in_sight
        ennemies_coming = rand(1..6)
        puts "----------------------"
        if @ennemies_in_sight.length == @players_left
            puts "tout les ennemies sont en vue"
        elsif ennemies_coming == 1
            puts "pas d ennemies en approche"
        elsif ennemies_coming >= 5
            ennemies_number = rand(1..100)
            player_sight = Player.new("player_#{ennemies_number}a")
            @ennemies_in_sight << player_sight
            print "un ennemie approche : "
            player_sight.show_state
        else
            print "deux ennemies en approche : "
            2.times do
                ennemies_number = rand(1..100)
                player_sight = Player.new("player_#{ennemies_number}b")
                @ennemies_in_sight << player_sight
                player_sight.show_state
                print ", "
            end
        end
    end

    #les ennemies attaque un par un le joueru
    def ennemies_attack
        puts "--------------------------"
        @ennemies_in_sight.each do |e|
            e.attacks(@human_player)
        end
    end

    #fin de parti looser or winner
    def end
        puts "la partie est termine"
        if @human_player.life_points == 0
            puts "tu as perdu" 
        else 
            puts "tu as gagne"
        end
    end
end