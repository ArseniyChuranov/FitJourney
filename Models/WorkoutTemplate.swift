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
 
    Add Date in future to organize in Specific way.
 
 
 */

import Foundation
import Combine 


// Workout template is essentially a workout, it contains unique ID, workout name, exercises, and a theme

struct WorkoutTemplate: Identifiable, Codable {
    var id: UUID
    var title: String
    var exercise: [ExerciseData]
    var theme: Theme
    var history: [History] = []
    
    init(id: UUID = UUID(), title: String, exercise: [ExerciseData], theme: Theme) {
        self.id = id
        self.title = title
        self.exercise = exercise
        self.theme = theme
    }
}


extension WorkoutTemplate {
    
    // ExerciseData is essentialy an exercise, each exercise have a name, at least one set with one rep, and weight for it. it has a possibility to have more
    
    struct ExerciseData: Identifiable, Codable {
        let id: UUID
        var workoutName: String
        var exerciseSets: [ExerciseSet]
        
        init(id: UUID = UUID(), workoutName: String, exerciseSets: [ExerciseSet]) {
            self.id = id
            self.workoutName = workoutName
            self.exerciseSets = exerciseSets
        }
    }
    
    // all Exercise Set data was moved to a new struct
    
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
    
    mutating func update(from data: Data) {
        title = data.title
        exercise = data.exercise
        theme = data.theme
    }
    
    init(data: Data){
        id = UUID()
        title = data.title
        exercise = data.exercise
        theme = data.theme
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
    
    static let emptyWorkouts: [WorkoutTemplate] = []
}

