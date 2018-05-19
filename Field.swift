struct Field {
    let xCoordinate: Int
    let yCoordinate: Int 
    var occupant: Any?
    var canStepHere: Bool = true

    init(xCoordinate: Int, yCoordinate: Int) {
        self.xCoordinate = xCoordinate
        self.yCoordinate = yCoordinate
        occupant = nil
    }

    init(xCoordinate: Int, yCoordinate: Int, occupant: Any) {
        self.xCoordinate = xCoordinate
        self.yCoordinate = yCoordinate
        self.occupant = occupant
    }

    mutating func removeOccupant() {
        occupant = nil
    }

    func checkForOccupant() -> Bool {
        if occupant != nil {
            return true
        } else {
            return false
        }
    }

    func getOccupantType() -> Any {
        return type(of: occupant)
    }

    mutating func addOccupant(who newOcc: Any) -> Bool {
        if occupant == nil {
            occupant = newOcc
            return true
        } 
        return false
    }

    mutating func makeUnreachable() {
        canStepHere = false
    }
}