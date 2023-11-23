//
//  ChartView.swift
//  Fitness
//
//  Created by Simone Sarnataro on 14/11/23.
//

import SwiftUI
import Charts

struct ChartView: View {
    @EnvironmentObject var manager: HealthKitManager
    var body: some View {
        VStack {
            Chart {
                ForEach(manager.hourlyCalorieData) { hourly in
                    BarMark(x: .value(hourly.date.formatted(), hourly.date, unit: .hour), y: .value("Calories", hourly.calorieCount))
                }
            }.padding(.horizontal, -2)
                .frame(height: 125)
                .foregroundColor(.ringColor1)
                .accessibilityHidden(true)
        }
    }
}
