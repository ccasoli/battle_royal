#parent
#class Player qui permet de creer un joueur avec 10 point de vie 
class Player 
    attr_accessor :life_points, :name

    #un joueur a un nom et de la vie : 10 pour tout le monde
    def initialize(name)
        @name = name
        @life_points = 10
    end

    #on affiche le nom et les points de vie 
    def show_state 
        puts "#{@name} à #{@life_points} points de vie"
    end

    #methode qui inflige des degats : damage
    def get_damage(damage)
        @life_points = @life_points - damage
        #on verife si le joueur est mort 
        #initialise la vie a 0 pour ne pas avoir de nombre negatif
        if @life_points <= 0
            @life_points = 0
            puts "le joueur #{@name} a ete tue"
            puts ""
        end
    end

    #methode qui permet d attaquer
    #affiche qui attauqe qui
    #le joueur attaquer perd des degat en fonction du rand
    def attacks(player_to_attack)
        puts "#{@name} attaque #{player_to_attack.name}"
        damage = compute_damage
        puts "infligue #{damage} point de degat"
        puts ""
        player_to_attack.get_damage(damage)
    end

    #degats subit sont choisi au hazard entre 1 et 6
    def compute_damage
        return rand(1..6)
    end
end

#class enfant de player recupere nom et point de vie
class HumanPlayer < Player
    attr_accessor :weapon_level

    # initialize HumanPlayer avec 100 points de vie et une arme niveau 1
    def initialize(name)
        super(name)
        @weapon_level = 1
        @life_points = 100
    end

    #affiche nom point de vie et niveau de larme du joueur
    def show_state
        puts "#{@name} a #{@life_points} points de vie et une arme de niveau #{@weapon_level}"
    end

    #les degats sont toujours aleatoire mais proportionnel au niveau de l arme
    def compute_damage
        rand(1..6) * @weapon_level
    end

    #choisi une amre au hazard et la prend si meilleur qu arme actuel
    def search_weapon
        new_weapon_level = rand(1..6)
        puts "#{name} a trouve une arme de niveau #{new_weapon_level}"
        if new_weapon_level > @weapon_level
            @weapon_level = new_weapon_level
            puts "il fait un changement d arme"
            puts ""
        else
            puts "pas de changement d arme"
            puts ""
        end
    end

    #prend un pack de vie en fonction du tirage
    def search_health_pack
        use_health_pack = rand(1..6)
        #pas de vie
        if use_health_pack == 1
            puts "rien ne ce passe"
            puts ""
        #un gros pack de vie verif life ne depasse pas 100
        elsif use_health_pack == 6
            @life_points += 80
            @life_points = 100 if @life_points > 100
            puts "tu te heal pour 80HP"
            puts ""
        #un moyen pack de vie verif life ne depasse pas 100
        else
            @life_points += 50
            @life_points = 100 if @life_points > 100
            puts "tu te heal pour 50HP"
            puts ""
        end
    end
end