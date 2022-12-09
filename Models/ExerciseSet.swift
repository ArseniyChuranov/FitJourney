//
//  ExerciseTemplate.swift
//  Fit Journey
//
//  Created by Arseniy Churanov on 12/8/22.
//

import Foundation


struct ExerciseSet: Identifiable, Codable {
    let id: UUID
    var sets: Int // think about making sets individual in order, it will make it simpler to store and to read
    var reps: Int
    var weight: Int
    
    init(id: UUID = UUID(),sets: Int, reps: Int, weight: Int) {
        self.id = id
        self.sets = sets // will use it as a count measure for now. later might be a problem so will adopt a new strategy
        self.reps = reps
        self.weight = weight
    }
}

extension ExerciseSet {
    
    // for countablity i should add an id system to keep track of each set and so on. can be used as a good trend system in future
    // ExerciseSet is a list of sets per exercise with reps and weight
    
    
    
    // Struct Sets allows to pass bindings of ExerciseSet
    
    struct Sets {
        var sets: Int = 0
        var reps: Int = 0
        var weight: Int = 0
    }
    
    // variable SetsData allows to create new Sets??
    
    var setsData: Sets {
        Sets(sets: sets, reps: reps, weight: weight)
    }
    
    mutating func updateSets(from setsData: Sets) {
        sets = setsData.sets
        reps = setsData.reps
        weight = setsData.weight
    }
    
    init(setsData: Sets) {
        id = UUID()
        sets = setsData.sets
        reps = setsData.reps
        weight = setsData.weight
    }
    
}
