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

// Workout template is essentially a workout, it contains unique ID, workout name, exercises, and a theme

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
    
    // ExerciseData is essentialy an exercise, each exercise have a name, at least one set with one rep, and weight for it. it has a possibility to have more
    
    struct ExerciseData: Identifiable {
        let id: UUID
        var workoutName: String
        var exerciseSets: [ExerciseSet]
        
        init(id: UUID = UUID(), workoutName: String, exerciseSets: [ExerciseSet]) {
            self.id = id
            self.workoutName = workoutName
            self.exerciseSets = exerciseSets
        }
    }
    
    // for countablity i should add an id system to keep track of each set and so on. can be used as a good trend system in future
    // ExerciseSet is a list of sets per exercise with reps and weight
    
    struct ExerciseSet: Identifiable {
        let id: UUID
        let sets: Int // think about making sets individual in order, it will make it simpler to store and to read
        let reps: Int
        let weight: Int
        
        init(id: UUID = UUID(),sets: Int, reps: Int, weight: Int) {
            self.id = id
            self.sets = sets // will use it as a count measure for now. later might be a problem so will adopt a new strategy
            self.reps = reps
            self.weight = weight
        }
    }
    
    // Struct Sets allows to pass bindings of ExerciseSet
    
    struct Sets {
        var sets: [ExerciseSet] = [] //WorkoutTemplate.sampleData[0].exercise[0].exerciseSets // no
    }
    
    // variable SetsData allows to create new Sets??
    
    var setsData: Sets {
        Sets()
    }
    
    // struct Data allows to create new workouts and pass them as bindings // study this
    
    struct Data {
        var title: String = ""
        var exercise: [ExerciseData] = []
        var theme: Theme = .seafoam
    }
    
    // var data allows to pass Data as binding??
    
    var data: Data {
        Data(title: title, exercise: exercise, theme: theme)
    }
}


extension WorkoutTemplate {
    static let sampleData: [WorkoutTemplate] =
    [
        WorkoutTemplate(title: "Push", exercise: [
            ExerciseData(workoutName: "Bench Press", exerciseSets: [ExerciseSet(sets: 1, reps: 12, weight: 70),
                                                                    ExerciseSet(sets: 2, reps: 10, weight: 120),
                                                                    ExerciseSet(sets: 3, reps: 6, weight: 150)]),
            ExerciseData(workoutName: "Military Press", exerciseSets: [ExerciseSet(sets: 1, reps: 12, weight: 50),
                                                                       ExerciseSet(sets: 2, reps: 8, weight: 85),
                                                                       ExerciseSet(sets: 3, reps: 6, weight: 100)]),
            ExerciseData(workoutName: "Pushups", exerciseSets: [ExerciseSet(sets: 1, reps: 12, weight: 100),
                                                                ExerciseSet(sets: 2, reps: 8, weight: 150)])
        ], theme: .seafoam),
        WorkoutTemplate(title: "Pull", exercise: [
            ExerciseData(workoutName: "Pull-ups", exerciseSets: [ExerciseSet(sets: 1, reps: 10, weight: 0),
                                                                 ExerciseSet(sets: 2, reps: 8, weight: 10),
                                                                 ExerciseSet(sets: 3, reps: 6, weight: 20)]),
            ExerciseData(workoutName: "Biceps Curls", exerciseSets: [ExerciseSet(sets: 1, reps: 10, weight: 20),
                                                                     ExerciseSet(sets: 2, reps: 8, weight: 30),
                                                                     ExerciseSet(sets: 3, reps: 6, weight: 45)])
        ], theme: .lavender),
        WorkoutTemplate(title: "Legs", exercise: [
            ExerciseData(workoutName: "Squats", exerciseSets: [ExerciseSet(sets: 1, reps: 14, weight: 120),
                                                               ExerciseSet(sets: 2, reps: 8, weight: 160),
                                                               ExerciseSet(sets: 3, reps: 6, weight: 240)]),
            ExerciseData(workoutName: "Romanian Deadlift", exerciseSets: [ExerciseSet(sets: 1, reps: 12, weight: 60),
                                                                          ExerciseSet(sets: 2, reps: 10, weight: 80),
                                                                          ExerciseSet(sets: 3, reps: 8, weight: 120)])
        ], theme: .navy)
    
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
 
 ExerciseData(workoutName: "Military Press", sets: 4, reps: 8, weight: 120),
 ExerciseData(workoutName: "Pushups", sets: 3, reps: 12, weight: 0)
 
 */
