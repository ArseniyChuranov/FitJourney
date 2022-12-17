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
    
    @Binding var newExerciseList: [String]

    
    @State private var newExerciseName = ""
    @State private var newExerciseSets: [ExerciseSet] = []
    
    @State private var showPicker = false
    @State private var currentPick = 0
    
    @FocusState private var focused: textField?
    
    var body: some View {
        List {
            Section {
                ForEach(0..<newExerciseList.count, id: \.self) {exercise in
                    TextField(newExerciseList[exercise], text:  $newExerciseList[exercise])
                }
                .onDelete {indices in
                    newExerciseList.remove(atOffsets: indices)
                }
        
                HStack {
                    TextField("New Exercise", text: $newExerciseName)
                        .font(.title)
                        .focused($focused, equals: .exerciseName)
                        .onSubmit {
                            if(!newExerciseName.isEmpty) {
                                
                                newExerciseList.append(newExerciseName)
                                newExerciseName = ""
                                if(focused != .exerciseName) {
                                    focused = .exerciseName
                                }
                            }
                        }
                    
                    Button (action: {
                        withAnimation {
                            newExerciseList.append(newExerciseName)
                            newExerciseName = ""
                            if(focused != .exerciseName) {
                                focused = .exerciseName
                            }
                        }
                    }) {
                        Image(systemName: "plus")
                    }
                    .disabled(newExerciseName.isEmpty)
                }
                // create a view input that will take data and insert it to thiw view
            }
        }
    }
}

struct DetailEditView_Previews: PreviewProvider {
    static var emptyExerciseData = WorkoutTemplate.Data(title: "Workout", exercise: [WorkoutTemplate.ExerciseData(workoutName: "No Sets", exerciseSets: [])])
    
    static var previews: some View {
        Group {
            DetailEditView(newExerciseList: .constant([]))
                .previewDisplayName("Exercises with Sets")
            
            DetailEditView(newExerciseList: .constant([]))
                .previewDisplayName("Empty Exercises")
        }
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
