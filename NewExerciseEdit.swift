//
//  NewExerciseEdit.swift
//  Fit Journey
//
//  Created by Arseniy Churanov on 11/8/22.
//
// 
//

import SwiftUI

struct NewExerciseEdit: View {
    
    @State private var data = WorkoutTemplate.Data()
    
    @State private var newExerciseName = ""
    @State private var newExerciseValue = 0.0
    @State private var newExerciseSetsValue = ""
    @State private var newExerciseRepsValue = ""
    
    var body: some View {
        Form {
            Section(header: Text("New Exercise")) {
                //TextField("Title", text: $data.title)
                ForEach(data.exercise) { title in
                    Text(title.workoutName)
                    // fill the rest with other stuff
                }
                .onDelete { indices in
                    data.exercise.remove(atOffsets: indices)
                }
                VStack {
                    HStack {
                        TextField("New Exercise", text: $newExerciseName)
                        Button (action: {
                            withAnimation {
                                let exercise = WorkoutTemplate.ExerciseData(workoutName: newExerciseName,
                                                                            exerciseSets: [WorkoutTemplate.ExerciseSet(sets: 1, reps: 1, weight: 1)]) // should be added later with other inputs.
                                data.exercise.append(exercise)

                            }
                        }) {
                            Image(systemName: "plus")
                        }
                        .disabled(newExerciseName.isEmpty)
                    }
                    Spacer()
                    HStack {
                        TextField("Sets", text: $newExerciseSetsValue)
                        Spacer()
                        TextField("Reps", text: $newExerciseRepsValue)
                    }
                }
            }
        }
    }
}

struct NewExerciseEdit_Previews: PreviewProvider {
    static var previews: some View {
        NewExerciseEdit()
    }
}
