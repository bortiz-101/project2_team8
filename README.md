# project2_team8
Project: Alloy Model for Vehicle and Job Allocation
Overview

This project models a system where vehicles (passenger, cargo, and pickup) are used to transport people and materials to various locations, such as dwellings, workplaces, and warehouses. The system ensures that jobs are completed only when the required number of people and materials are present at the corresponding workplace. This model is designed using Alloy, a declarative language used for modeling and analyzing systems.

The project is divided into two phases:
Phase 1: Structural Aspects

    Vehicles: The project models three types of vehicles:
        Passenger vehicles: Transport people with a maximum number of seats.
        Cargo vehicles: Transport materials with a maximum capacity.
        Pickup vehicles: Transport both passengers and materials with a specified capacity.

    Locations: Various locations such as dwellings, workplaces, and warehouses are modeled, each with specific attributes like available people, materials, and maximum capacities.

    Jobs: A job requires a specific number of workers (people) and materials. A workplace specifies the number of workers and materials required to complete a task.

    Constraints: The project ensures that the number of passengers and cargo in each vehicle does not exceed its capacity.

Phase 2: Dynamic Aspects

    Movement: The model defines actions like moving people and cargo between locations, ensuring the consistency with vehicle capacity.

    Job Completion: Jobs are considered completed when at least the required number of workers and materials are present at the corresponding workplace.

Files in the Project
1. simple.als

This file contains the structural aspects of the model, including:

    The definition of vehicles (passenger, cargo, pickup).
    Locations such as dwellings, workplaces, and warehouses.
    Jobs and their requirements (workers and materials).
    Constraints ensuring that the vehicle capacities are not exceeded and that workers and materials are allocated correctly.

2. stateful.als

This file models the dynamic aspects of the system, including:

    The state transitions, such as moving vehicles, loading and unloading people/materials, and job completion.
    Facts and predicates for handling the movement of people and materials between locations.

The state is modeled as a set of locations, cargo, and passengers in vehicles. The transitions allow for the simulation of moving people and materials and checking if jobs can be completed.
Running the Model
1. Prerequisites:

Before running the model, ensure you have Java installed on your system. If Java is not installed, download it from the official website.
2. Steps to Run:

    Download Alloy Analyzer:
        Go to Alloy Tools and download the appropriate version for your operating system.

    Open Alloy Analyzer:
        Launch Alloy Analyzer by running the alloy.bat file (on Windows) or the alloy.jar file (on other systems).

    Load the .als Files:
        Open Alloy Analyzer and load the simple.als and stateful.als files.
            Click on File > Open and select your .als file.

    Run the Model:
        In the command box at the bottom of the Alloy Analyzer window, run the following commands to execute the model:

        run project2 {}    // In simple.als or stateful.als

        Alloy will attempt to find an instance that satisfies the constraints and display the results.

3. Understanding the Model:

    The model will show you the current allocation of people, vehicles, and materials.
    You can verify whether a job can be completed by checking if the required number of people and materials are at the correct workplace.
    If a job can be completed, Alloy will provide a visual representation of the state.

Important Facts and Predicates

    finish Predicate:
        Ensures that a job can only be completed if there are enough workers and materials at the corresponding workplace.

    Vehicle Capacity Constraints:
        Ensure that passenger and cargo vehicles do not exceed their capacity.

    Movement of People and Materials:
        Defines the actions for moving people and materials between locations, considering the vehicle capacity.

Example Test Case

Here’s a simple test case to check if a job can be completed based on the required number of workers and materials:

fact init {
    // Ensure initial conditions
    some c: Cargo_V | c in Cargo_V
    some p: Passenger_V | p in Passenger_V
    some t: Pickup_V | t in Pickup_V
    all v: Vehicle | one loc: (Warehouses + Workplaces + Dwellings) | v -> loc in InitialState.locations
}

run project2 {}

Expected Behavior:

    The system will check if the job can be completed with the available workers and materials.
    If it is possible, Alloy will return a solution; otherwise, it will indicate that the constraints are not met.

Conclusion

This model simulates a system where vehicles transport people and materials to different locations and ensures jobs are completed when all conditions are met. The main goal is to validate if jobs can be completed based on the availability of workers and materials and whether the vehicle capacities are respected. 