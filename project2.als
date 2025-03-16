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

fact workplace_needs {
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

pred empty_cargo {
    all v: Cargo_V | v.cargo = none
}

pred empty_passenger {
    all v: Passenger_V | v.passengers = none
}

pred empty_pickup {
    all v: Pickup_V | v.P_cargo = none
    all v: Pickup_V | v.P_passengers = none
}

pred load_cargo_warehouse [v: Cargo_V, m: Materials, w: Warehouses] {
    m in w.material_needed
    m in v.cargo
}

pred load_cargo_workplace [v: Cargo_V, m: Materials, wp: Workplaces] {
    m in wp.materials_needed
    m in v.cargo
}

pred load_passenger_dwellings [v: Passenger_V, p: People, d: Dwellings] {
    p in d.tenants
    p in v.passengers
}

pred load_passenger_workplace [v: Passenger_V, p: People, wp: Workplaces] {
    p in wp.employees_needed
    p in v.passengers
}

pred load_passenger_warehouse [v: Passenger_V, p: People, w: Warehouses] {
    p in w.employees_needed
    p in v.passengers
}

pred load_pickup_dwellings [v: Pickup_V, p: People, d: Dwellings] {
    p in d.tenants
    p in v.P_passengers
}

pred load_pickup_workplace [v: Pickup_V, m: Materials, p: People, wp: Workplaces] {
    m in wp.materials_needed
    m in v.P_cargo
    p in wp.employees_needed
    p in v.P_passengers
}

pred load_pickup_warehouse [v: Pickup_V, m: Materials, p: People, w: Warehouses] {
    m in w.material_needed
    m in v.P_cargo
    p in w.employees_needed
    p in v.P_passengers
}

pred load_pickup_dwellings [v: Pickup_V, p: People, d: Dwellings] {
    p in d.tenants
    p in v.P_passengers
}

pred load_passenger [v: Passenger_V, p: People] {
    p in v.passengers
}

pred load_pickup [v: Pickup_V, m: Materials, p: People] {
    m in v.P_cargo
    p in v.P_passengers
}

pred unload_cargo_warehouse [v: Cargo_V, m: Materials, w: Warehouses] {
    m !in v.cargo
    m in w.material_needed
}

pred unload_cargo_workplace [v: Cargo_V, m: Materials, wp: Workplaces] {
    m !in v.cargo
    m in wp.materials_needed
}

pred unload_passenger_warehouse [v: Passenger_V, p: People, w: Warehouses] {
    p !in v.passengers
    p in w.employees_needed
}

pred unload_passenger_workplace [v: Passenger_V, p: People, wp: Workplaces] {
    p !in v.passengers
    p in wp.employees_needed
}

pred unload_passenger_dwellings [v: Passenger_V, p: People, d: Dwellings] {
    p !in v.passengers
    p in d.tenants
}

pred unload_pickup_warehouse [v: Pickup_V, m: Materials, p: People, w: Warehouses] {
    m !in v.P_cargo
    m in w.material_needed
    p !in v.P_passengers
    p in w.employees_needed
}

pred unload_pickup_workplace [v: Pickup_V, m: Materials, p: People, wp: Workplaces] {
    m !in v.P_cargo
    m in wp.materials_needed
    p !in v.P_passengers
    p in wp.employees_needed
}

pred unload_pickup_dwellings [v: Pickup_V, p: People, d: Dwellings] {
    p !in v.P_passengers
    p in d.tenants
}

run project2 {} for 5
