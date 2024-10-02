//
//  WeekView.swift
//  Project_Version1
//
//  Created by Pro on 11/1/23.
//

import SwiftUI

struct WeekView: View {
    @StateObject private var dataManager = DailyDataManager()
    var currentDate: Date = Date()
    
    private var daysInWeek: [Date] {
        let calendar = Calendar.current
        guard let sunday = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: currentDate)) else { return [] }
        return (0..<7).compactMap {
            calendar.date(byAdding: .day, value: $0, to: sunday)
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                ForEach(daysInWeek, id: \.self) { day in
                    VStack {
                        CalendarDayView(date: day, isCurrentMonth: true, dailyData: dataManager.fetchEntry(for: day))
                            .frame(maxWidth: .infinity)
                    }
                }
            }
        }
    }
    
    // Helper methods
    
    private func weekdayName(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        return formatter.string(from: date)
    }
}
struct WeekView_Previews: PreviewProvider {
    static var previews: some View {
        WeekView()
    }
}


#Preview {
    WeekView()
}
