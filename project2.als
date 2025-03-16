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
var sig Dwellings extends Locations{
    tenants: set People,
    max_tenants: lone Int
}
var sig Workplaces extends Locations{
    employees: set People,
    materials_needed: set Materials,
    max_capacity: lone Int
}
var sig Warehouses extends Locations{
    materials: set Materials,
    max_capacity: lone Int,
    employees: set People,
    max_employees: lone Int
}

fact init {
    no Cargo_V
    no Passenger_V
    no Pickup_V    
}

fact max_capacity {
    // Sets max capacity to 6500 lbs
    all v: Cargo_V | v.max_capacity = 6500
}

fact max_passengers {
    // Sets max passengers to 16
    all v: Passenger_V | v.max_passengers = 16
}

fact dwelling_needs {
    // Each dwelling has maximum number People
    all d: Dwellings | d.max_tenants = 6
}

fact factory_needs {

}

fact warehouse_needs {

}

run project2 {} for 5
