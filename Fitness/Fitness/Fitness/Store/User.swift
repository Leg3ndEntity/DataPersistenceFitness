//
//  User.swift
//  Fitness
//
//  Created by Simone Sarnataro on 16/11/23.
//

import Foundation
import SwiftData

@Model class User {
    var birthDate: Date
    var sex: String
    var weight: Double
    var height: Double
    
    init(birthDate: Date, sex: String, weight: Double, height: Double) {
        self.birthDate = birthDate
        self.sex = sex
        self.weight = weight
        self.height = height
    }
}
