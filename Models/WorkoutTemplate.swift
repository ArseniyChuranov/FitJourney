//
//  WorkoutTemplate.swift
//  Fit Journey
//
//  Created by Arseniy Churanov on 11/7/22.
//

// Add date to templates, think of what else could be useful during workout of after workouts.
// Maybe add a set table for sets in future?
// Have a convertor from imperial to metric syste, for inputs

// maybe create different init depending on option user would choose for weight system measurements (kgs/ lbs)

/*
 As of November 29 2022 I have decided to start with a a simple template for workouts
    Each workout will have ID, Name, Exercises, and Theme
    
    Each exercise will have at least 1 set cell with weight value. (id?, name, set, rep, weight)
 
    Each set cell will have set value, number of reps, and weigth. Each set can be deleted.
 
 
 */

import Foundation

struct WorkoutTemplate: Identifiable {
    var id: UUID
    var title: String
    var exercise: [ExerciseData]
    var theme: Theme
    
    init(id: UUID = UUID(), title: String, exercise: [ExerciseData], theme: Theme) {
        self.id = id
        self.title = title
        self.exercise = exercise // found a better solution // [CompleteWorkoutData.init(workoutName: "Bench Press", sets: 5, reps: 12, weight: 150)] // it scares me // how to pass a sample data value
        self.theme = theme
    }
}

// i donth think i need this one, the workout template should have all of the info
// create a better method to store workouts, with proper info.

extension WorkoutTemplate {
    
    //while following tutotial im not sure i need this.
    
    struct Exercise: Identifiable {
        let id: UUID
        var name: String
        
        init(id: UUID = UUID(), name: String) {
            self.id = id
            self.name = name
        }
    }
    
    struct ExerciseData: Identifiable {
        let id: UUID
        var workoutName: String
        var sets: Int?
        var reps: Int?
        var weight: Int?
        
        init(id: UUID = UUID(), workoutName: String, sets: Int, reps: Int, weight: Int) {
            self.id = id
            self.workoutName = workoutName
            self.sets = sets
            self.reps = reps
            self.weight = weight
        }
    }
    
    // for countablity i should be able 
    
    struct ExerciseSet {
        let set: Int
        let rep: Int
        let weight: Int
        
        init(set: Int, rep: Int, weight: Int) {
            self.set = set
            self.rep = rep
            self.weight = weight
        }
    }
    
    struct Data {
        var title: String = ""
        var exercise: [ExerciseData] = []
        /*
        [
            CompleteWorkoutData(workoutName: "Bench Press", sets: 3, reps: 20, weight: 150),
            CompleteWorkoutData(workoutName: "Military Press", sets: 4, reps: 82, weight: 120),
           CompleteWorkoutData(workoutName: "Pushups", sets: 3, reps: 22, weight: 0)
        ]
         */
        //  [ CompleteWorkoutData(workoutName: "New Workout", sets: 0, reps: 0, weight: 0) ] // can be left empty but for now its like this
        var theme: Theme = .seafoam
    }
    
    var data: Data {
        Data(title: title, exercise: exercise, theme: theme)
    }
}



extension WorkoutTemplate {
    struct ExerciseValue: Identifiable, Hashable {
        let id: UUID
        var value: Double
        
        init(id: UUID = UUID(), value: Double) {
            self.id = id
            self.value = value
        }
    }

}
 

extension WorkoutTemplate {
    static let sampleData: [WorkoutTemplate] =
    [
        WorkoutTemplate(title: "Push", exercise: [
            ExerciseData(workoutName: "Bench Press", sets: 3, reps: 10, weight: 150),
            ExerciseData(workoutName: "Military Press", sets: 4, reps: 8, weight: 120),
            ExerciseData(workoutName: "Pushups", sets: 3, reps: 12, weight: 0)
        ], theme: .seafoam),
        WorkoutTemplate(title: "Pull", exercise: [], theme: .lavender),
        WorkoutTemplate(title: "Legs", exercise: [], theme: .navy)
    
    ]
}



/*
 
 extension WorkoutTemplate {
     static let sampleData: [WorkoutTemplate] =
     [
         WorkoutTemplate(title: "Push", exercise: ["Bench press", "Military Press", "Pushups", "Shoulder Press"], exerciseValue: [140.0, 100.0, 10, 35.0 ], theme: .seafoam),
         WorkoutTemplate(title: "Pull", exercise: ["Deadlift", "Pullups", "Cable Triceps Curl"], exerciseValue: [200.0, 5.0, 30.0], theme: .lavender),
         WorkoutTemplate(title: "Legs", exercise: ["Squats", "Romanian Deadlift", "Quad Curls", "Calve Raises"], exerciseValue: [150.0, 100.0, 80.0, 25.0], theme: .navy)
     
     ]
 }
 
 */
