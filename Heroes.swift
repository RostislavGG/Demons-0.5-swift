import Monsters

func powOfTwo(of n: Int) -> Int {
    if n == 0 {
        return 1
    }
    return 2 * powOfTwo(of: n-1)
}

protocol CharacterAbillities {
    func Attack(who: Monster)
    func Defend(from: Monster)
    func LevelUp()
}


class Character {
    var name: String
    var level: Int = 0
    var hp: Double
    var strength: Int
    var intellect: Int
    var kills = 0

    init(name: String, hp: Double, strength: Int, intellect: Int) {
        self.name = name
        self.hp = hp
        self.strength = strength
        self.intellect = intellect
    }
}

class Barbarian: Character {
    var rage: Int = 0
    var hasUsedRage = false
    var maxHp = 100
    init() {
        super.init(name: "Test", hp: 100, strength: 10, intellect: 3)
    }
}

extension Barbarian: CharacterAbillities {
    func Battle(with enemy: Monster) {
        let oldStrength = self.strength
        self.strength += Int(rage/5)
        rage = 0
        var willAttack = true

        while self.hp <= 0 || enemy.hp <= 0 {
            if willAttack {
                Attack(who: enemy)
                rage += 2
                willAttack = false
            } else {
                Defend(from: enemy)
                rage += 3
                willAttack = true
            }
        }

        if self.hp <= 0 {
            print("You died noob")
        } else if enemy.hp <= 0 {
            print("You killed the enemy")
        }

        self.strength = oldStrength
        if kills > powOfTwo(of: level) {
            LevelUp()
        }
    }

    func Attack(who enemy: Monster) {
        enemy.hp -= Double(self.strength) + 0.2*Double(self.intellect)
    }

    func Defend(from enemy: Monster) {
        
    }

    func LevelUp() {
        maxHp += Int(maxHp/10)
    }

    func Heal() {
        hp = Double(maxHp)
    }

    func Print() {
        print("\(name) - \(type(of: self))")
        print("HP - \(hp)/\(maxHp) | Strength - \(strength) | Intellect - \(intellect) | Rage - \(rage)")
    }
}