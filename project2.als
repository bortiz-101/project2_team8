abstract sig Vehicle {}
var sig Cargo_V in Vehicle {}
var sig Passenger_V in Vehicle {}
var sig People {}
var sig Materials {}
abstract sig Locations {}
var sig Dwellings extends Locations{}
var sig Workplaces extends Locations{}
var sig Warehouses extends Locations{}

fact init {
    
}

run project2 {} for 5
