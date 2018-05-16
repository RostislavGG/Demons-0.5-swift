import Monsters

func powOfTwo(of n: Int) -> Int {
    if n == 0 {
        return 1
    }
    return 2 * powOfTwo(of: n-1)
}

protocol CharacterAbillities {
    func attack(who: Monster)
    func defend(from: Monster)
    func levelUp()
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
    func battle(with enemy: Monster) {
        let oldStrength = self.strength
        self.strength += Int(rage/5)
        rage = 0
        var willAttack = true

        if enemy is Necromancer {
            let newEnemy = enemy as! Necromancer
            var toAttack = true
            while self.hp >= 0 && newEnemy.hp >= 0 {
                if newEnemy.minion.hp > 0 {
                    while self.hp >= 0 && newEnemy.minion.hp >= 0 {
                        if toAttack {
                            attack(who: newEnemy.minion)
                            toAttack = false
                        } else {
                            defend(from: newEnemy.minion)
                            defend(from: newEnemy)
                            toAttack = true
                        }
                    }
                } else {
                    while self.hp >= 0 && newEnemy.hp >= 0 {
                        if toAttack {
                            attack(who: newEnemy)
                            toAttack = false
                        } else {
                            defend(from: newEnemy)
                            toAttack = true
                        }
                    }
                }
            }

        } else {
            while self.hp >= 0 && enemy.hp >= 0 {
                if willAttack {
                    attack(who: enemy)
                    rage += 2
                    willAttack = false
                } else {
                    defend(from: enemy)
                    rage += 3
                    willAttack = true
                }
            }
        }

        if self.hp <= 0 {
            print("You died noob")
        } else if enemy.hp <= 0 {
            print("You killed the enemy")
        }

        self.strength = oldStrength
        if kills > powOfTwo(of: level) {
            levelUp()
        }
    }

    func attack(who enemy: Monster) {
        enemy.hp -= Double(self.strength) + 0.2*Double(self.intellect)
    }

    func defend(from enemy: Monster) {
        if enemy is Skeleton {
            let enemy2 = enemy as! Skeleton
            self.hp = enemy2.attack(enemyHp: self.hp, enemyStr: self.strength, enemyIn: self.intellect)
        } else if enemy is Heretic {
            let enemy2 = enemy as! Heretic
            self.hp = enemy2.attack(enemyHp: self.hp, enemyStr: self.strength, enemyIn: self.intellect)
        } else if enemy is Necromancer {
            let enemy2 = enemy as! Necromancer
            self.hp = enemy2.attack(enemyHp: self.hp, enemyStr: self.strength, enemyIn: self.intellect)
        } else if enemy is Demon {
            let enemy2 = enemy as! Demon
            self.hp = enemy2.attack(enemyHp: self.hp, enemyStr: self.strength, enemyIn: self.intellect)
        }
    }

    func levelUp() {
        maxHp += Int(maxHp/10)
    }

    func heal() {
        hp = Double(maxHp)
    }

    func printData() {
        print("\(name) - \(type(of: self))")
        print("HP - \(hp)/\(maxHp) | Strength - \(strength) | Intellect - \(intellect) | Rage - \(rage)")
    }
}