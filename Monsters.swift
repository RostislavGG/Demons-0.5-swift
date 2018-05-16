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

protocol AttackAndPrint {
    func attack(enemyHp eHp: Double, enemyStr eSt: Int, enemyIn eIn: Int) -> Double
    func printData()
}

class Skeleton: Monster {
    let maxHp: Int = 32
    let xCoordinate: Int
    let yCoordinate: Int

    init(xCoordinate: Int, yCoordinate: Int) {
        self.xCoordinate = xCoordinate
        self.yCoordinate = yCoordinate
        super.init(name: "Skeleton", hp: 32, strength: 3, intellect: 0)
    }
}

extension Skeleton: AttackAndPrint {
    func attack(enemyHp eHp: Double, enemyStr eSt: Int, enemyIn eIn: Int) -> Double {
        return eHp - Double(self.strength) - 1/10*Double(eIn)
    }

    func printData() {
        print("\(name) - \(hp)/\(maxHp)HP")
        print("Strength - \(strength) | Intellect - \(intellect)")
    }
}

class Heretic: Monster {
    let maxHp: Int = 20
    let xCoordinate: Int
    let yCoordinate: Int

    init(xCoordinate: Int, yCoordinate: Int) {
        self.xCoordinate = xCoordinate
        self.yCoordinate = yCoordinate
        super.init(name: "Heretic", hp: 20, strength: 1, intellect: 4)
    }
}

extension Heretic: AttackAndPrint {
    func attack(enemyHp eHp: Double, enemyStr eSt: Int, enemyIn eIn: Int) -> Double {
        if eSt < eIn {
            return eHp - Double(self.intellect) - Double(eSt)
        } else {
            return eHp - Double(self.intellect) - Double(eIn)
        }
    }

    func printData() {
        print("\(name) - \(hp)/\(maxHp)HP")
        print("Strength - \(strength) | Intellect - \(intellect)")
    }
}

class Necromancer: Monster {
    var minion: Skeleton
    let xCoordinate: Int
    let yCoordinate: Int
    let maxHp: Int = 65

    init(xCoordinate: Int, yCoordinate: Int) {
        self.xCoordinate = xCoordinate
        self.yCoordinate = yCoordinate
        self.minion = Skeleton(xCoordinate: self.xCoordinate, yCoordinate: self.yCoordinate) /// Lazy
        super.init(name: "Necromancer", hp: 65, strength: 2, intellect: 7)
    }
}

extension Necromancer: AttackAndPrint {
    func attack(enemyHp eHp: Double, enemyStr eSt: Int, enemyIn eIn: Int) -> Double {
        if minion.hp >= 0 {
            return eHp - Double(intellect) - minion.hp/10
        } else {
            return eHp - Double(intellect)
        }
    }

    func printData() {
        if minion.hp < 0 {
            print("\(name) - \(hp)/\(maxHp)HP")
            print("Strength - \(strength) | Intellect - \(intellect)")
        } else {
            print("\(name) - \(hp)/\(maxHp)HP")
            print("Strength - \(strength) | Intellect - \(intellect)")
            print("Minion -  \(minion.printData())")
        }
    }
}

class Demon: Monster, AttackAndPrint {
    let maxHp: Int = 350
    var fightingStyle = true
    let xCoordinate: Int
    let yCoordinate: Int

    init(xCoordinate: Int, yCoordinate: Int) {
        self.xCoordinate = xCoordinate
        self.yCoordinate = yCoordinate
        super.init(name: "Diablo", hp: 350, strength: 8, intellect: 4)
    }
}

extension Demon {
    func attack(enemyHp eHp: Double, enemyStr eSt: Int, enemyIn eIn: Int) -> Double {
        if fightingStyle {
            fightingStyle = false
            return eHp - Double(self.strength) - 1/10*Double(eIn)
        } else {
            fightingStyle = true
            if eSt < eIn {
                return eHp - Double(self.intellect) - Double(eSt)
            } else {
                return eHp - Double(self.intellect) - Double(eIn)
            }
        }
    }

    func printData() {
        print("\(name) - \(hp)/\(maxHp)HP")
        print("Strength - \(strength) | Intellect - \(intellect)")
    }
}