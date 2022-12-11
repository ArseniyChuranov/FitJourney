//
//  DetailEditView.swift
//  Fit Journey
//
//  Created by Arseniy Churanov on 11/10/22.
//
//  This View is an Edit View of a workout page, allowing to edit each individual exercise.
//

import SwiftUI

struct DetailEditView: View {
    
    @Binding var data: WorkoutTemplate.Data
    
    @State private var newExerciseName = ""
    @State private var newExerciseSets: [ExerciseSet] = []
    
    @State private var showPicker = false
    @State private var currentPick = 0
    
    var body: some View {
        List {
            Section(header: Text(data.title)) {
                
                if(data.exercise.isEmpty) {
                    
                    HStack {
                        TextField("New Exercise", text: $newExerciseName)
                        Button (action: {
                            
                            // create a color picker
                            let newExercise = WorkoutTemplate.ExerciseData(workoutName: newExerciseName, exerciseSets: newExerciseSets)
                            data.exercise.append(newExercise)
                            newExerciseName = ""
                        }) {
                            Image(systemName: "plus")
                        }
                        .disabled(newExerciseName.isEmpty)
                    }
                } else {
                    ForEach($data.exercise) {$exercise in
                        // do i need a group here?
                        Group {
                            ListExerciseCardView(exercise: exercise)
                        }
                    }
                    
                    
                    HStack {
                        TextField("New Exercise", text: $newExerciseName)
                            .font(.title)
                        Button (action: {
                            
                            // create a color picker
                            let newExercise = WorkoutTemplate.ExerciseData(workoutName: newExerciseName, exerciseSets: newExerciseSets)
                            data.exercise.append(newExercise)
                            newExerciseName = ""
                        }) {
                            Image(systemName: "plus")
                        }
                        .disabled(newExerciseName.isEmpty)
                    }
                    
                }
                // create a view input that will take data and insert it to thiw view
            }
        }
    }
}

struct DetailEditView_Previews: PreviewProvider {
    static var previews: some View {
        DetailEditView(data: .constant(WorkoutTemplate.sampleData[0].data))
    }
}



/*
HStack {
    Text("\(currentPick)")
    Spacer()
    .onTapGesture {
        withAnimation {
            self.showPicker.toggle()
        }
    }
    // showing picker doesn't seem like the most ideal way, as well as whole adding exercise. It will be my task later to replace this system with a better one.
    if showPicker {
        Picker("Pounds", selection: $data.exercis) {
            ForEach(1...10, id: \.self) { number in
                Text("\(number)").tag(number)
            }
        }
        .pickerStyle(.wheel)
     
    }
} */





// v2

/*
 
 ForEach(data.exercise) { exercise in
         VStack {
             HStack {
                 Label(exercise.workoutName, systemImage: "dumbbell")
                 Spacer()
                 Text("Weight")
                 Text(String(Int(exercise.weight != nil ? exercise.weight! : 0))) // THAT WORKED
             }
             Spacer()
             HStack {
                 Text("Reps")
                 Text(String(Int(exercise.sets != nil ? exercise.sets! : 0)))
                 Spacer()
                 Text("Sets")
                 Text(String(Int(exercise.reps != nil ? exercise.reps! : 0)))
             }
         }
     }
 
 */
