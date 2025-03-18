abstract sig Vehicle {}

sig Cargo_V in Vehicle {
    cargo: set Materials,
    max_capacity: one Int
}

sig Passenger_V in Vehicle {
    passengers: set People,
    max_passengers: one Int
}

sig Pickup_V extends Vehicle {
    P_passengers: set People,
    P_max_passengers: one Int,
    P_cargo: set Materials,
    P_max_capacity: one Int
}

sig Job extends Workplaces {
    workers: set People,
    resources: set Materials
}

sig Complete_Job in Job {}

sig People {}

sig Materials {}

abstract sig Locations {}

sig Dwellings extends Locations {
    tenants: set People,
    max_tenants: one Int
}

sig Workplaces extends Locations {
    employees_needed_wp: one Int,
    materials_needed_wp: one Int
}

sig Warehouses extends Locations {
    materials: set Materials
}


fact constraints {

    all v: Passenger_V | #v.passengers <= v.max_passengers

    all v: Cargo_V | #v.cargo <= v.max_capacity

    all v: Pickup_V |
        #v.P_passengers <= v.P_max_passengers and
        #v.P_cargo <= v.P_max_capacity

    all d: Dwellings | #d.tenants <= d.max_tenants
}

// The max capacities need work, whenever I re-enable my max capacities Alloy
// will not create vehicle instances

// fact max {

//     all v: Passenger_V | v.max_passengers >= 1 and v.max_passengers <= 16

//     all v: Cargo_V | v.max_capacity >= 1 and v.max_capacity <= 6500

//     all v: Pickup_V |
//         v.max_passengers >= 1 and v.max_passengers <= 5 and
//         v.max_capacity >= 1 and v.max_capacity <= 6500

//     all d: Dwellings | d.max_tenants >= 1 and d.max_tenants <= 30

//     all w: Workplaces |
//         w.employees_needed_wp >= 1 and w.employees_needed_wp <= 30 and
//         w.materials_needed_wp >= 1 and w.materials_needed_wp <= 6500
// }


pred finish [j: Job, w: Workplaces] {
    #j.workers >= w.employees_needed_wp
    #j.resources >= w.materials_needed_wp
    not j in Complete_Job
    Complete_Job' = Complete_Job + j
}


pred cargoV_move[j: Job,c: Cargo_V, w:Workplaces, m: Materials] {
    m in c.cargo
    #j.resources < w.materials_needed_wp
    j.resources' = j.resources + m
    c.cargo' = c.cargo - m
}

pred pickupV_move_cargo[j: Job,c: Pickup_V, w:Workplaces, m: Materials] {
    m in c.cargo
    #j.resources < w.materials_needed_wp
    j.resources' = j.resources + m
    c.cargo' = c.cargo - m
}


pred passengerV_move[j: Job, v: Passenger_V, w: Workplaces, p: People] {
    p in v.passengers
    #j.workers < w.employees_needed_wp
    j.workers' = j.workers + p
    v.passengers' = v.passengers - p
}

pred pickupV_move_passenger[j: Job, v: Pickup_V, w: Workplaces, p: People] {
    p in v.passengers
    #j.workers < w.employees_needed_wp
    j.workers' = j.workers + p
    v.passengers' = v.passengers - p
}

pred people_to_dwelling[d: Dwellings, p: People, v: Passenger_V] {
    p in v.passengers
    #d.tenants < d.max_tenants
    d.tenants' = d.tenants + p
    v.passengers' = v.passengers - p
}

pred empty_cargoV[c: Cargo_V]{
    some c.cargo 
    c.cargo' = none
}

pred empty_passengerV[v: Passenger_V]{
    some v.passengers
    v.passengers' = none
}

pred load_cargoV[c: Cargo_V, m: Materials, w: Warehouses]{
    m in w.materials
    #c.cargo <= c.max_capacity
    c.cargo' = c.cargo + m
    w.materials' = w.materials - m
}

pred load_passengerV[v: Passenger_V, p: People, d: Dwellings]{
   p in d.tenants
   #v.passengers < v.max_passengers
   v.passengers' = v.passengers + p
   d.tenants' = d.tenants - p
}


fact init {
    no Complete_Job
}

run project2 {}
