//
//  WorkoutView.swift
//  Fit Journey
//
//  Created by Arseniy Churanov on 11/7/22.
//

import SwiftUI

struct WorkoutView: View {
    @State private var exercise = ""
    
    var body: some View {
        Form {
            VStack {
                Section(header: Text("Exercise")) {
                    HStack {
                        TextField("Exercise", text: $exercise)
                        Button(action: {}) {
                            Image(systemName: "plus.circle.fill")
                        }
                    }
                }
                        
            }
        }
    }
}

struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView()
    }
}
