//
//  SetsWithRepsCardView.swift
//  Fit Journey
//
//  Created by Arseniy Churanov on 11/29/22.
//

import SwiftUI

struct SetsWithRepsCardView: View {
    // let exerciseSets: WorkoutTemplate.ExerciseSet
    @Binding var exercise: WorkoutTemplate.ExerciseData

    
    
    var body: some View {
        VStack {
            Text("\(exercise.workoutName)")
            ForEach(exercise.exerciseSets) {individualSets in
                HStack{
                    Text(String(individualSets.reps))
                    Text(String(individualSets.weight))
                }
            }
            Button(action: {
                let newSet = ExerciseSet(sets: exercise.exerciseSets.count + 1,
                                                         reps: 1,
                                                         weight: 1
                )
                
                exercise.exerciseSets.append(newSet)
            }) {
                Image(systemName: "plus")
                
            }
        }
       // .padding()
    }
}

struct SetsWithRepsCardView_Previews: PreviewProvider {
    static var previews: some View {
        SetsWithRepsCardView(exercise: .constant(WorkoutTemplate.sampleData[0].exercise[0]))
    }
}
