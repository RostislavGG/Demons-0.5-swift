class Monster {
    var name: String
    var hp: Double
    var strength: Int
    var intellect: Int

    init(name: String, hp: Double, strength: Int, intellect: Int) {
        self.name = name
        self.hp = hp
        self.strength = strength
        self.intellect = intellect
    }
}

class Skeleton: Monster {
    init() {
        super.init(name: "Skeleton", hp: 32, strength: 3, intellect: 0)
    }

    func (enemyHp ehp: Double, enemyStr est: Int, enemyIn: Int)
}

class Heretic: Monster {
    init() {
        super.init(name: "Heretic", hp: 20, strength: 1, intellect: 4)
    }

    func Attack() 
}

class Necromancer: Monster {

}

class Demon: Monster {
    
}