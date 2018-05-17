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
    func printData()
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
    var xCoordinate: Int
    var yCoordinate: Int

    init(name: String, xCoordinate: Int, yCoordinate: Int) {
        super.init(name: name, hp: 100, strength: 10, intellect: 3)
        self.xCoordinate = xCoordinate
        self.yCoordinate = yCoordinate
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
                            rage += 2
                            toAttack = false
                        } else {
                            defend(from: newEnemy.minion)
                            rage += 3
                            defend(from: newEnemy)
                            rage += 3
                            toAttack = true
                        }
                    }
                } else {
                    kills += 1
                    while self.hp >= 0 && newEnemy.hp >= 0 {
                        if toAttack {
                            attack(who: newEnemy)
                            rage += 2
                            toAttack = false
                        } else {
                            defend(from: newEnemy)
                            rage += 3
                            toAttack = true
                        }
                    }
                }
            }
        enemy.hp = newEnemy.hp
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
        if kills >= powOfTwo(of: level) {
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
        heal()
    }

    func heal() {
        hp = Double(maxHp)
    }

    func printData() {
        print("\(name) - \(type(of: self))")
        print("HP - \(hp)/\(maxHp) | Strength - \(strength) | Intellect - \(intellect) | Rage - \(rage)")
    }

    func changePos(newX x: Int, newY y: Int) {
        xCoordinate = x
        yCoordinate = y
    }
}


class Mage: Character {
    var mana: Int
    var maxHp = 70
    var maxMana = 100
    var xCoordinate: Int
    var yCoordinate: Int
    
    init(name: String, xCoordinate: Int, yCoordinate: Int) {
        super.init(name: name, hp: 70, strength: 4, intellect: 12)
        self.xCoordinate = xCoordinate
        self.yCoordinate = yCoordinate
    }
}

extension Mage: CharacterAbillities {
    func battle(with enemy: Monster) {
        var willAttack = true
        if enemy is Necromancer {
            let newEnemy = enemy as! Necromancer
            while self.hp >= 0 && newEnemy.hp >= 0 {
                if newEnemy.minion.hp > 0 {
                    while self.hp >= 0 && newEnemy.minion.hp >= 0 {
                        if willAttack {
                            attack(who: newEnemy.minion)
                        } else {
                            defend(from: newEnemy.minion)
                            defend(from: newEnemy)
                        }
                    }
                } else {
                    kills += 1
                    while self.hp >= 0 && newEnemy.hp >= 0 {
                        if willAttack {
                            attack(who: newEnemy)
                            willAttack = false
                        } else {
                            defend(from: newEnemy)
                            willAttack = true
                        }
                    }
                }
            }
            enemy.hp = newEnemy.hp
        } else {
            while self.hp >= 0 && enemy.hp >= 0 {
                if willAttack {
                    attack(who: enemy)
                    willAttack = false
                } else {
                    defend(from: enemy)
                    willAttack = true
                }
            }
        }

        if enemy.hp <= 0 {
            kills += 1
        }

        mana = maxMana
        if kills >= powOfTwo(of: level) {
            levelUp()
        }
    }

    func attack(who enemy: Monster) {
        enemy.hp -= (Double(strength) / 2 + (Double(mana) / Double(maxMana)) * 3/4) * self.intellect
        if mana > 0 {
            mana -= maxMana/10
        }
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
        maxHp += maxHp/10
        maxMana += maxMana/10
        heal()
    }

    func heal() {
        hp = Double(maxHp)
        mana = maxMana
    }

    func printData() {
        print("\(name) - \(type(of: self))")
        print("HP - \(hp)/\(maxHp) | Strength - \(strength) | Intellect - \(intellect) | Mana - \(mana)/\(maxMana)")
    }

    func changePos(newX x: Int, newY y: Int) {
        xCoordinate = x
        yCoordinate = y
    }
}

class BountyHunter: Character {
    var maxHp = 80
    var agility: Int = 10
    var xCoordinate: Int
    var yCoordinate: Int
    var kills = 0

    init(name: String, xCoordinate: Int, yCoordinate: Int) {
        super.init(name: name, hp: 80, strength: 9, intellect: 6)
        self.xCoordinate = xCoordinate
        self.yCoordinate = yCoordinate
    }
}

extension BountyHunter: CharacterAbillities {
    func battle(with enemy: Monster) {
        var toAttackHard = 1
        var toAttack = true

        if enemy is Necromancer {
            let newEnemy = enemy as! Necromancer
            while self.hp >= 0 && newEnemy.hp >= 0 {
                if newEnemy.minion.hp >= 0 {
                    while self.hp >= 0 && newEnemy.minion.hp >= 0 {
                        if toAttack {
                            if toAttackHard == 3 {
                                hardAttack(who: newEnemy.minion)
                                toAttackHard = 1
                            } else {
                                attack(who: newEnemy.minion)
                                toAttackHard += 1
                            }   
                            toAttack = false
                        } else {
                            defend(from: newEnemy.minion)
                            defend(from: newEnemy)
                            toAttack = true
                        }
                    }
                    if newEnemy.minion.hp < 0 {
                        kills += 1
                    }
                } else {
                    while self.hp >= 0 && newEnemy.hp >= 0 {
                        if toAttack {
                            if toAttackHard == 3 {
                                hardAttack(who: newEnemy)
                                toAttackHard = 1
                                toAttack = false
                            } else {
                                attack(who: newEnemy)
                                toAttackHard += 1
                            }
                        } else {
                            defend(from: newEnemy)
                            toAttack = true
                        }
                    }
                }
            }
            enemy.hp = newEnemy.hp
        } else {
            while self.hp >= 0 && newEnemy.hp >= 0 {
                if toAttack {
                    if toAttackHard == 3 {
                        hardAttack(who: newEnemy)
                        toAttackHard = 1
                        toAttack = false
                    } else {
                        attack(who: newEnemy)
                        toAttackHard += 1
                    }
                } else {
                    defend(from: newEnemy)
                    toAttack = true
                }
            }
        }

        if enemy.hp < 0 {
            kills += 1
        }

        if kills >= powOfTwo(of: level) {
            levelUp()
        }
    }

    func attack(who enemy: Monster) {
        enemy.hp -= 0.8 * Double(agility)
    }

    func hardAttack(who enemy: Monster) {
        enemy.hp -= Double(agility) - 0.4 * Double(intellect) - 0.6 * Double(strength)
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
        maxHp += maxHp/10
        agility += 4
        heal()
    }

    func heal() {
        hp = Double(maxHp)
    }

    func printData() {
        print("\(name) - \(type(of: self))")
        print("HP - \(hp)/\(maxHp) | Strength - \(strength) | Intellect - \(intellect) | Agility - \(agility)")
    }

    func changePos(newX x: Int, newY y: Int) {
        xCoordinate = x
        yCoordinate = y 
    }
}