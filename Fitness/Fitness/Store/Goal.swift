//
//  Goal.swift
//  Fitness
//
//  Created by Simone Sarnataro on 23/11/23.
//

import Foundation
import SwiftData

@Model class Goal{
    var goal: Int
    
    init(goal: Int) {
        self.goal = goal
    }
}
