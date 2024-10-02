//
//  DailyData.swift
//  Project_Version1
//
//  Created by Pro on 10/20/23.
//

import Foundation

struct DailyData: Codable, Identifiable {
    let id: UUID
    let date: Date
    let selectedButtons: [Int]     // Indices or IDs of the selected buttons.
    let foodDescription: String    // What they ate that day.
    let dayDescription: String     // Additional details about their day.
    let mood: String
    
}
