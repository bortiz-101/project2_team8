abstract sig Vehicle {}
sig Cargo_V in Vehicle {
    cargo: set Materials,
    max_capacity: lone Int
}
sig Passenger_V in Vehicle {
    passengers: set People,
    max_passengers: lone Int
}
sig Pickup_V extends Vehicle {
    P_cargo: set Materials,
    P_passengers: set People
}
sig People {}
sig Materials {}
abstract sig Locations {}
sig Dwellings extends Locations{
    tenants: set People,
    max_tenants: lone Int
}
sig Workplaces extends Locations{
    employees_needed: set People,
    materials_needed: set Materials,
    max_capacity: lone Int
}
sig Warehouses extends Locations{
    material_needed: set Materials,
    max_capacity: lone Int,
    employees_needed: set People,
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
    // Each factory needs 5 employees
    all f: Workplaces | f.employees_needed = 5
    // Each factory needs 1000 lbs of material
    all f: Workplaces | f.materials_needed = 1000

}

fact warehouse_needs {
    // Each warehouse needs 5 employees
    all w: Warehouses | w.employees_needed = 5
    // Each warehouse needs 1000 lbs of material
    all w: Warehouses | w.material_needed = 1000
}

run project2 {} for 5
