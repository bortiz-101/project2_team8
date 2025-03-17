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
    P_passengers: set People
}
sig People {}
sig Materials {}

abstract sig Locations {}

sig Dwellings extends Locations {
    tenants: set People,
    max_tenants: one Int,
    available_people: set People
}
sig Workplaces extends Locations {
    employees_needed: one Int,
    materials_needed: one Int,
    available_materials: set Materials,
    available_people: set People
}
sig Warehouses extends Locations {
    material_needed: one Int,
    employees_needed: one Int,
    available_materials: set Materials,
    available_people: set People
}

fact init {
    no Cargo_V
    no Passenger_V
    no Pickup_V    
}

fact capacities {
    all c: Cargo_V | c.max_capacity = 6500
    all p: Passenger_V | p.max_passengers = 16
    all d: Dwellings | d.max_tenants = 6
    all loc: Workplaces + Warehouses | {
        (loc in Workplaces implies {
            loc.(Workplaces <: employees_needed) = 5 and loc.materials_needed = 1000
        }) and 
        (loc in Warehouses implies {
            loc.(Warehouses <: employees_needed) = 5 and loc.material_needed = 1000
        })
    }
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

sig State {
    locations: Vehicle -> one (Warehouses + Workplaces + Dwellings),
    cargo: Cargo_V -> set Materials,
    passengers: Passenger_V -> set People,
    pickup_cargo: Pickup_V -> set Materials,
    pickup_passengers: Pickup_V -> set People
}

pred move [s: State, sNext: State, v: Vehicle, loc: (Warehouses + Workplaces + Dwellings)] {
    // Explicitly declare and scope oldLoc
    some oldLoc: (Warehouses + Workplaces + Dwellings) | {
        v in s.locations[oldLoc]

        // The vehicle moves to the new location
        sNext.locations = (s.locations - v -> oldLoc) + (v -> loc)
    }

    // Other states remain unchanged
    sNext.cargo = s.cargo
    sNext.passengers = s.passengers
    sNext.pickup_cargo = s.pickup_cargo
    sNext.pickup_passengers = s.pickup_passengers
}


pred load_material [s, sNext: State, v: (Cargo_V + Pickup_V), m: Materials, loc: Workplaces + Warehouses] {
    (loc in Workplaces implies m in (loc <: Workplaces).available_materials) or
    (loc in Warehouses implies m in (loc <: Warehouses).available_materials)

    // Material is loaded onto the vehicle
    v in Cargo_V implies m in sNext.cargo[v]
    v in Pickup_V implies m in sNext.pickup_cargo[v]

    // Other states remain unchanged
    sNext.locations = s.locations
    sNext.passengers = s.passengers
    sNext.pickup_passengers = s.pickup_passengers
}

pred load_person [s, sNext: State, v: (Passenger_V + Pickup_V), p: People, loc: (Warehouses + Workplaces + Dwellings)] {
    (loc in Dwellings implies p in (loc <: Dwellings).available_people) or
    (loc in Workplaces implies p in (loc <: Workplaces).available_people) or
    (loc in Warehouses implies p in (loc <: Warehouses).available_people)

    // Add the person to the vehicle
    v in Passenger_V implies p in sNext.passengers[v]
    v in Pickup_V implies p in sNext.pickup_passengers[v]

    // Other states remain unchanged
    sNext.locations = s.locations
    sNext.cargo = s.cargo
    sNext.pickup_cargo = s.pickup_cargo
}

pred unload_material [s, sNext: State, v: (Cargo_V + Pickup_V), m: Materials, loc: (Warehouses + Workplaces)] {
    v in Cargo_V implies m in s.cargo[v]
    v in Pickup_V implies m in s.pickup_cargo[v]
    v in Cargo_V implies m not in s'.cargo[v]
    v in Pickup_V implies m not in s'.pickup_cargo[v]
    s'.locations = s.locations
    s'.passengers = s.passengers
    s'.pickup_passengers = s.pickup_passengers
}

pred unload_person [s: State, sNext: State, v: (Passenger_V + Pickup_V), p: People, loc: (Warehouses + Workplaces + Dwellings)] {
    v in Passenger_V implies p in s.passengers[v]
    v in Pickup_V implies p in s.pickup_passengers[v]
    v in Passenger_V implies p not in s'.passengers[v]
    v in Pickup_V implies p not in s'.pickup_passengers[v]
    s'.locations = s.locations
    s'.cargo = s.cargo
    s'.pickup_cargo = s.pickup_cargo
}

fact trans {
    all s, sNext: State, v: Vehicle | 
        (some loc: (Warehouses + Workplaces + Dwellings) | move[s, sNext, v, loc]) or
        (some loc: (Warehouses + Workplaces), m: Materials | load_material[s, sNext, v, m, loc]) or
        (some loc: (Warehouses + Workplaces + Dwellings), p: People | load_person[s, sNext, v, p, loc]) or
        (some loc: (Warehouses + Workplaces), m: Materials | unload_material[s, sNext, v, m, loc]) or
        (some loc: (Warehouses + Workplaces + Dwellings), p: People | unload_person[s, sNext, v, p, loc])
}

run project2 {} for 5