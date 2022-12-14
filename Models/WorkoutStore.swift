//
//  WorkoutStore.swift
//  Fit Journey
//
//  Created by Arseniy Churanov on 12/9/22.
//

import Foundation
import SwiftUI

class WorkoutStore: ObservableObject {
    @Published var workouts: [WorkoutTemplate] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("workouts.data")
    }
    
    static func load() async throws -> [WorkoutTemplate] {
        try await withCheckedThrowingContinuation {continuation in
            load { result in
                switch result {
                case .failure(let error):
                    continuation.resume(throwing: error)
                case .success(let workout):
                    continuation.resume(returning: workout)
                }
            }
        }
    }
    
    static func load(completion: @escaping (Result<[WorkoutTemplate], Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try fileURL()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success([]))
                    }
                    return
                }
                let workout = try JSONDecoder().decode([WorkoutTemplate].self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(.success(workout))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    @discardableResult
    static func save(workouts: [WorkoutTemplate]) async throws -> Int {
        try await withCheckedThrowingContinuation {continuation in
            save(workouts: workouts) {result in
                switch result {
                case .failure(let error):
                    continuation.resume(throwing: error)
                case .success(let workoutSaved):
                    continuation.resume(returning: workoutSaved)
                }
            }
        }
    }
    
    static func save(workouts: [WorkoutTemplate], completion: @escaping (Result<Int, Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(workouts)
                let outfile = try fileURL()
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(workouts.count))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
