//
//  CalendarViewModel.swift
//  Project_Version1
//
//  Created by Pro on 10/31/23.
//

import SwiftUI

class CalendarViewModel: ObservableObject {
    @Published var entries: [DailyData] = []

    func mood(for date: Date) -> String? {
        let startOfDay = Calendar.current.startOfDay(for: date)
        return entries.first(where: { Calendar.current.startOfDay(for: $0.date) == startOfDay })?.mood
    }
}
