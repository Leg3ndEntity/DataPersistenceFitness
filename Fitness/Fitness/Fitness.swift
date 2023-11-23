//
//  Fitness.swift
//  Fitness
//
//  Created by Simone Sarnataro on 22/11/23.
//

import SwiftUI
import SwiftData

struct Fitness: View {
    @StateObject var healthKitManager = HealthKitManager()
    @AppStorage("isWelcomeScreenOver") var isWelcomeScreenOver = false
    @State var checkWelcomeScreen: Bool = false
    
    var body: some View {
        VStack {
            if checkWelcomeScreen {
                ContentView()
//                    .environmentObject(healthKitManager)
//                    .preferredColorScheme(.dark)
//                    .onAppear {
//                        healthKitManager.requestAuthorization { success in
//                            if success {
//                                healthKitManager.startEnergyQuery(quantityTypeIdentifier: .activeEnergyBurned)
//                                healthKitManager.startStepQuery(quantityTypeIdentifier: .stepCount)
//                                healthKitManager.startWalkQuery(quantityTypeIdentifier: .distanceWalkingRunning)
//                            } else {
//                                print("HealthKit non autorizzato.")
//                            }
//                        }
//                    }
            } else {
                LoginView(height: "", weight: "")
//                    .environmentObject(healthKitManager)
//                    .preferredColorScheme(.dark)
//                    .onAppear {
//                        healthKitManager.requestAuthorization { success in
//                            if success {
//                                healthKitManager.startEnergyQuery(quantityTypeIdentifier: .activeEnergyBurned)
//                                healthKitManager.startStepQuery(quantityTypeIdentifier: .stepCount)
//                                healthKitManager.startWalkQuery(quantityTypeIdentifier: .distanceWalkingRunning)
//                            } else {
//                                print("HealthKit non autorizzato.")
//                            }
//                        }
//                    }
            }
        }
        .onAppear {
            checkWelcomeScreen = isWelcomeScreenOver
        }
    }
}

#Preview {
    Fitness()
}
