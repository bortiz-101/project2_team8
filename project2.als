abstract sig Vehicle {}
var sig Cargo_V in Vehicle {
    cargo: set Materials,
    max_capacity: lone Int
}
var sig Passenger_V in Vehicle {
    passengers: set People,
    max_passengers: lone Int
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
