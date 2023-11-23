//
//  FitnessApp.swift
//  Fitness
//
//  Created by Simone Sarnataro on 14/11/23.
//

import SwiftUI
import SwiftData

@main
struct FitnessApp: App {
    @StateObject var healthKitManager = HealthKitManager()
    
    var body: some Scene {
        WindowGroup {
            Fitness()
                .environmentObject(healthKitManager)
                .preferredColorScheme(.dark)
                .onAppear {
                    healthKitManager.requestAuthorization { success in
                        if success {
                            healthKitManager.startEnergyQuery(quantityTypeIdentifier: .activeEnergyBurned)
                            healthKitManager.startStepQuery(quantityTypeIdentifier: .stepCount)
                            healthKitManager.startWalkQuery(quantityTypeIdentifier: .distanceWalkingRunning)
                        } else {
                            print("HealthKit non autorizzato.")
                        }
                    }
                }
        }
        .modelContainer(for: [User.self, Goal.self])
    }
}

