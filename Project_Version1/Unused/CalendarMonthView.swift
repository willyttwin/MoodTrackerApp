//
//  CalendarMonthView.swift
//  Project_Version1
//
//  Created by Pro on 10/31/23.
//

import SwiftUI

struct CalendarMonthView: View {
    var currentDate: Date = Date()
    
    @StateObject private var dataManager = DailyDataManager()

    private var daysInMonth: [Date] {
        guard let range = Calendar.current.range(of: .day, in: .month, for: currentDate) else { return [] }
        return Array(range).compactMap {
            Calendar.current.date(byAdding: .day, value: $0-1, to: startOfMonth(date: currentDate))
        }
    }

    var body: some View {
        VStack {
            HStack {
                ForEach(0..<7) { index in
                    Text(weekdayName(index: index))
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.bottom, 4)

          ForEach(Array(0..<numberOfWeeksInMonth()), id: \.self) { week in
              HStack(spacing:20) {
                  ForEach(Array(0..<7), id: \.self) { weekday in
                      if let day = dateInCurrentMonthFor(week: week, weekday: weekday) {
                          CalendarDayView(date: day, isCurrentMonth: true)
                      } else {
                          let adjacentDate = dateInAdjacentMonthFor(week: week, weekday: weekday)
                          CalendarDayView(date: adjacentDate, isCurrentMonth: false)
                      }
                  }
              }
          }
        }
        .padding()
    }

    private func startOfMonth(date: Date) -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: date))!
    }

    private func weekdayName(index: Int) -> String {
        let weekdays = Calendar.current.veryShortWeekdaySymbols
        return weekdays[index]
    }

    private func numberOfWeeksInMonth() -> Int {
        return Calendar.current.range(of: .weekOfMonth, in: .month, for: currentDate)!.count
    }

    private func dateInCurrentMonthFor(week: Int, weekday: Int) -> Date? {
        let startWeekday = Calendar.current.component(.weekday, from: startOfMonth(date: currentDate)) - 1 // Convert to zero-indexed
        let dayOffset = week * 7 + weekday - startWeekday
        if dayOffset < 0 || dayOffset >= daysInMonth.count {
            return nil
        }
        return daysInMonth[dayOffset]
    }

    private func dateInAdjacentMonthFor(week: Int, weekday: Int) -> Date {
        let startWeekday = Calendar.current.component(.weekday, from: startOfMonth(date: currentDate)) - 1 // Convert to zero-indexed
        let dayOffset = week * 7 + weekday - startWeekday
        if dayOffset < 0 {
            return Calendar.current.date(byAdding: .day, value: dayOffset, to: startOfMonth(date: currentDate))!
        } else {
            return Calendar.current.date(byAdding: .day, value: dayOffset - daysInMonth.count + 1, to: daysInMonth.last!)!
        }
    }
}

#Preview {
    CalendarMonthView()
}
