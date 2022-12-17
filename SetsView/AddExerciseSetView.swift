//
//  EditExerciseCardView.swift
//  Fit Journey


//
//  Created by Arseniy Churanov on 12/3/22.
//

import SwiftUI

struct AddExerciseSetView: View {
    @Binding var exercise: WorkoutTemplate.ExerciseData
    @Binding var repsList: [String]
    @Binding var weightList: [String]
    
    @State private var reps = ""
    @State private var weight = ""
    
    
    @State private var exerciseNewSets = ExerciseSet.Sets()
    
    // Trying same method to keep separate values and later add them to the final view.
    // Dont think I can use focus here with keyboards as easy, seems to be more complex.
    
    // Seems like there are several complications on limiting input to numbers only, will use for now a slower method, but to make sure imput will only be Ints.
    // Probably a good idea to change weight value to double in future.
    
    
    @State private var displayText = "Add New Set"
    
    func filterResults(input: String) -> String {
        let filtered = input.filter { "0123456789".contains($0) }
        return filtered
    }
    
    var body: some View {
        ZStack {
            
            Color("Background") // a simple way to create a background color for now.
                .edgesIgnoringSafeArea(.all)
                .opacity(0.5)
            
            Form {
                Section(header: Text(exercise.workoutName)) {
                    ForEach(0..<repsList.count, id: \.self) {individualSet in
                        HStack {
                            Text("Set: \(individualSet + 1)")
                            Spacer()
                            TextField(repsList[individualSet], text: $repsList[individualSet])
                                .onHover {_ in
                                    // onHover might be a good way to change things, test and consider it
                                    let filteredReps = filterResults(input: repsList[individualSet])
                                    
                                    repsList.insert(filteredReps, at: individualSet)
                                    repsList.remove(at: individualSet + 1)
                                }
                                .keyboardType(.numberPad)
                            Spacer()
                            TextField(weightList[individualSet], text: $weightList[individualSet])
                                .onHover {_ in
                                    let filteredWeight = filterResults(input: weightList[individualSet])
                                    
                                    weightList.insert(filteredWeight, at: individualSet)
                                    weightList.remove(at: individualSet + 1)
                                }
                                .keyboardType(.numberPad)
                        }
                        .font(.title2)
                        .padding()
                    }
                    .onDelete {sets in
                        repsList.remove(atOffsets: sets)
                        weightList.remove(atOffsets: sets)
                    }
                    
                    
                    Section {
                        HStack {
                            Text("Set: \(repsList.count + 1)")
                            Spacer()
                            TextField("Reps", text: $reps)
                                .keyboardType(.numberPad)
                            Spacer()
                            TextField("Weight", text: $weight)
                                .keyboardType(.numberPad)
                        }
                        .font(.title2)
                        .padding()
                        
                        HStack {
                            Button(action: {
                                withAnimation {
                                    if(reps.isEmpty || weight.isEmpty) {
                                        // Alert(title: Text("Can't add empty Sets"))
                                    } else {
                                        // filter through an input Reps and Weights
                                        let filteredReps = reps.filter { "0123456789".contains($0) }
                                        if filteredReps != reps {
                                            self.reps = filteredReps
                                        }
                                        
                                        let filteredWeight = weight.filter { "0123456789".contains($0) }
                                        if filteredWeight != weight {
                                            self.weight = filteredWeight
                                        }
                                        // in case if filtered result is empty. Make sure it works properly
                                        if(reps.isEmpty || weight.isEmpty) {
                                            reps = "1"
                                            weight = "0"
                                        }
                                        
                                        repsList.append(reps)
                                        weightList.append(weight)
                                        
                                        reps = ""
                                        weight = ""
                                    }
                                }
                            }) {
                                HStack {
                                    // Simple way to center the button?
                                    Spacer()
                                    Text(displayText)
                                        .disabled(reps.isEmpty)
                                        .font(.title)
                                        .padding()
                                    Spacer()
                                    // .alignmentGuide(HorizontalAlignment.center, computeValue: {_ in 20})
                                }
                            }
                            
                        }
                    }
                }
            }
        }
    }
}

struct AddExerciseSetView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AddExerciseSetView(exercise: .constant(WorkoutTemplate.sampleData[0].exercise[0]), repsList: .constant([]), weightList: .constant([]))
                .previewDisplayName("Add Exercise Set View Light Theme")
            
            AddExerciseSetView(exercise: .constant(WorkoutTemplate.sampleData[0].exercise[0]), repsList: .constant([]), weightList: .constant([]))
                .previewDisplayName("Add Exercise Set View Dark Theme")
                .environment(\.colorScheme, .dark)
        }
    }
}


