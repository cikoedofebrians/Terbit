//
//  Untitled.swift
//  Terbit
//
//  Created by Ciko Edo Febrian on 25/03/25.
//

let constantDays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
let constantDaysInt = [1, 2, 3, 4, 5, 6, 7]

let constantMorningRoutine: [MorningActivity] = [
    MorningActivity(
        name: "Hydration",
        description: "Rehydrate your body after sleep",
        instructions: [
            "Drink a glass of water (8-16 oz)",
            "Add lemon for extra benefits if desired",
            "Wait 15-30 minutes before eating"
        ],
        duration: 5
    ),
    
    MorningActivity(
        name: "Meditation",
        description: "Clear your mind and set intentions",
        instructions: [
            "Find a quiet, comfortable space",
            "Sit with good posture",
            "Focus on your breath for 5-10 minutes",
            "Optionally use a guided meditation app"
        ],
        duration: 10
    ),
    
    MorningActivity(
        name: "Stretching",
        description: "Wake up your muscles and improve flexibility",
        instructions: [
            "Perform gentle neck rolls",
            "Do shoulder shrugs and rolls",
            "Stretch arms overhead",
            "Touch toes or do forward fold",
            "Do gentle spinal twists"
        ],
        duration: 7
    ),
    
    MorningActivity(
        name: "Exercise",
        description: "Boost energy and metabolism",
        instructions: [
            "Choose between yoga, brisk walk, or quick workout",
            "Aim for at least 15 minutes of movement",
            "Include both cardio and strength if possible"
        ],
        duration: 15
    ),
    
    MorningActivity(
        name: "Healthy Breakfast",
        description: "Fuel your body for the day",
        instructions: [
            "Include protein, healthy fats, and complex carbs",
            "Example: Eggs with avocado toast",
            "Or oatmeal with nuts and berries",
            "Avoid processed sugars"
        ],
        duration: 20
    ),
    
    MorningActivity(
        name: "Planning",
        description: "Set your priorities for the day",
        instructions: [
            "Review your calendar",
            "List top 3 priorities",
            "Visualize your successful day",
            "Check and respond to critical emails only"
        ],
        duration: 10
    ),
    
    MorningActivity(
        name: "Personal Growth",
        description: "Invest in self-improvement",
        instructions: [
            "Read 10 pages of a book",
            "Or listen to a podcast",
            "Or practice a language for 10 minutes"
        ],
        duration: 15
    )
]
