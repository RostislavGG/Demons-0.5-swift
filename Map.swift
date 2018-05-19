class Map {
    var field: [[Field]]
    var width: Int
    var height: Int
    var hero: Field

    init(field: [[Field]], width: Int, height: Int, hero: Field) {
        self.field = field
        self.width = width
        self.height = height
        self.hero = hero
    }
}

extension Map {
    func moveUp() {
        if hero.yCoordinate < height && field[hero.xCoordinate][hero.yCoordinate+1].canStepHere {
            field[hero.xCoordinate][hero.yCoordinate+1].occupant = hero.occupant
            hero.occupant = nil
            hero = field[hero.xCoordinate][hero.yCoordinate+1]
        } 
    }

    func moveDown() {
        if hero.yCoordinate > 0 && field[hero.xCoordinate][hero.yCoordinate-1].canStepHere {
            field[hero.xCoordinate][hero.yCoordinate-1].occupant = hero.occupant
            hero.occupant = nil
            hero = field[hero.xCoordinate][hero.yCoordinate-1]
        } 
    }

    func moveLeft() {
        if hero.xCoordinate > 0 && field[hero.xCoordinate-1][hero.yCoordinate].canStepHere {
            field[hero.xCoordinate-1][hero.yCoordinate].occupant = hero.occupant
            hero.occupant = nil
            hero = field[hero.xCoordinate-1][hero.yCoordinate]
        } 
    }

    func moveRight() {
        if hero.xCoordinate < width && field[hero.xCoordinate+1][hero.yCoordinate].canStepHere {
            field[hero.xCoordinate+1][hero.yCoordinate].occupant = hero.occupant
            hero.occupant = nil
            hero = field[hero.xCoordinate+1][hero.yCoordinate]
        } 
    }

    // TODO
    func checkForEnemies() -> Monster? {
        var i = -1
        while i < 2 {
            if field[hero.xCoordinate+i][hero.yCoordinate].occupant != nil {
                return (field[hero.xCoordinate+i][hero.yCoordinate].occupant as! Monster)
            }
            i += 2
        }
        i = -1
        while i < 2 {
            if field[hero.xCoordinate][hero.yCoordinate+i].occupant != nil {
                return (field[hero.xCoordinate][hero.yCoordinate+i].occupant as! Monster)
            }
            i += 2
        }
        return nil
    }

    func checkForEnemies() -> Bool {
        for i in 0..<width {
            for j in 0..<height {
                if field[i][j].checkForOccupant() {
                    return true
                }
            }
        }
        return false
    }

    typealias Coordinate = (x: Int, y: Int)  

    subscript(coordinates: Coordinate) -> Field {
        get {
            assert(coordinates.x > 0 && coordinates.x < width && coordinates.y > 0 && coordinates.y < height, "Not valid coordinates")
            return field[coordinates.x][coordinates.y]
        } set {
            assert(coordinates.x > 0 && coordinates.x < width && coordinates.y > 0 && coordinates.y < height, "Not valid coordinates")
            field[coordinates.x][coordinates.y] = newValue
        }
    }   
}