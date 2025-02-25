abstract sig Vehicle {}
var sig Cargo_V in Vehicle {
    cargo: set Materials
}
var sig Passenger_V in Vehicle {
    passengers: set People
}
var sig Pickup_V extends Vehicle {
    P_cargo: set Materials,
    P_passengers: set People
}
var sig People {}
var sig Materials {}
abstract sig Locations {}
var sig Dwellings extends Locations{}
var sig Workplaces extends Locations{}
var sig Warehouses extends Locations{}

fact init {
    
}

run project2 {} for 5
