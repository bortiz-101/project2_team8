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
    P_cargo: set Materials,
    P_max_capacity: one Int,
    P_passengers: set People,
    P_max_passengers: one Int
}
sig Job extends Workplaces {
    workers: set employees_needed_wp,
    resources: set materials_needed_wp
}
sig Complete_Job in Job {}

sig People {
    person: one Int
}

sig Materials {}

abstract sig Locations {}
sig Dwellings extends Locations{
    tenants: set People,
    max_tenants: one Int
}
sig Workplaces extends Locations{
    employees_needed_wp: one Int,
    materials_needed_wp: one Int
}
sig Warehouses extends Locations{
    material_available: set Materials
}
fact constraints {
    // Ensure passengers do not exceed capacity
    all v: Passenger_V | #v.passengers <= v.max_passengers
    
    // Ensure cargo does not exceed capacity
    all v: Cargo_V | #v.cargo <= v.max_capacity
    
    all v: Pickup_V | 
        #v.passengers <= v.max_passengers and
        #v.cargo <= v.max_capacity
}

pred finish [j : Job, w: Workplaces]{
    #j.workers >= w.employees_needed_wp
    #j.resources >= w.materials_needed_wp
    not j in Complete_Job
    Complete_Job' = Complete_Job + j
}

fact capacity {
    all v: Cargo_V | v.max_capacity >= 1 and v.max_capacity <= 100
    all p: Passenger_V | p.max_passengers >= 1 and p.max_passengers <= 16
    all t: Dwellings | t.max_tenants >= 1 and t.max_tenants <= 10
}

pred material_to_job[j: Job, w: Warehouses, m: Materials] {
    m in w.material_available
    w.material_available' = w.material_available - m
    j.resources' = j.resources + m
}

pred people_to_job[j: Job, p: People]{
    not p.person in j.workers
    j.employees_needed_wp' = j.employees_needed_wp + p    
}
pred people_to_dwelling[d: Dwellings, p: People]{
    #d.tenants < d.max_tenants
    not p in d.tenants
    d.tenants' = d.tenants + p    
}

fact init {
   no Complete_Job
}


run project2 {}