//
//  ListExerciseCardView.swift
//  Fit Journey
//
//  Created by Arseniy Churanov on 12/9/22.
//

import SwiftUI

struct ListExerciseCardView: View {
    
    let exercise: WorkoutTemplate.ExerciseData
    
    
    var body: some View {
        ZStack {
            Color("Background") // a simple way to create a background color for now.
                .edgesIgnoringSafeArea(.all)
                .opacity(0.5)
            VStack {
                HStack {
                    Text(exercise.workoutName)
                        .font(.title)
                }
                ForEach(exercise.exerciseSets) {individualSet in
                    HStack {
                        Text("Set:")
                        Text(String("\(individualSet.sets)"))
                        Spacer()
                        Text("Reps:")
                        Text(String(individualSet.reps))
                        Spacer()
                        Text("Weight:")
                        Text(String(individualSet.weight))
                    }
                }
            }
            .padding()
        }
    }
}

struct ListExerciseCardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ListExerciseCardView(exercise: WorkoutTemplate.sampleData[0].exercise[0])
            
            ListExerciseCardView(exercise: WorkoutTemplate.sampleData[0].exercise[0])
                .environment(\.colorScheme, .dark)
        }
    }
}
