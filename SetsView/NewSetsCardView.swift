//
//  NewSetsCardView.swift
//  Fit Journey
//
//  Created by Arseniy Churanov on 11/29/22.
//

import SwiftUI

struct NewSetsCardView: View {
    
    let exerciseSets: ExerciseSet
    
    
    
    @State private var sets = ExerciseSet.Sets()
    @State private var exercise = WorkoutTemplate.Data()
    
    @State private var newSet = 0
    @State private var newRep = ""
    @State private var newWeight = ""
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                TextField("Reps", text: $newRep)
                    .font(.largeTitle)
                    .keyboardType(.numberPad)
                TextField("Weight", text: $newWeight)
                    .font(.largeTitle)
                    .keyboardType(.numberPad)
            }
            HStack {
                Button(action: {
                    withAnimation {
                        /*
                        let newSet = ExerciseSet(sets: newSet + 1,
                                                 reps: Int(newRep) ?? 1,
                                                 weight: Int(newWeight) ?? 0)
                         */
                    }
                }) {
                    Text("Add New Set")
                        .font(.largeTitle)
                        .disabled(newRep.isEmpty)
                }
            }
        }
        .padding()
    }
}

struct NewSetsCardView_Previews: PreviewProvider {
    static var exerciseSets = ExerciseSet(sets: 1, reps: 1, weight: 10)
    // static var exercise = WorkoutTemplate.ExerciseData(workoutName: "New exercise", exerciseSets: [exerciseSets] )
    
    static var previews: some View {
        NewSetsCardView(exerciseSets: exerciseSets)
        
    }
}
