//
//  CalendarDayView.swift
//  Project_Version1
//
//  Created by Pro on 10/31/23.
//

import SwiftUI


struct CalendarDayView: View {
  var date: Date
  var isCurrentMonth: Bool
  var dailyData: DailyData?
  
  var isBeforeOrOnToday: Bool {
    let today = Calendar.current.startOfDay(for: Date())
    let dayDate = Calendar.current.startOfDay(for: date)
    return dayDate <= today
  }
  
  var body: some View {
    Group {
      if isBeforeOrOnToday {
        // If date is on or before today, use a NavigationLink
        NavigationLink(destination: DayDetailView(dailyData: dailyData ?? DailyData.placeholder(for: date))) {
          calendarContent
        }
      } else {
        // If date is after today, display content without interactivity
        calendarContent
      }
    }
  }
  var calendarContent: some View {
    VStack {
      if let mood = dailyData?.mood, !mood.isEmpty {
        Image(mood)
          .resizable()
          .frame(width: 28, height: 28)
      } else {
        Circle()
          .fill(Color("DarkGray"))
          .frame(width: 28, height: 28)
      }
      Spacer().frame(height: 0)
      Text("\(dayNumber(for: date))")
        .foregroundColor(isCurrentMonth ? Color.black : Color.gray)
        .font(.system(size: 12, weight: .semibold))
    }
  }
  
  private func dayNumber(for date: Date) -> Int {
    let dayNumber = Calendar.current.component(.day, from: date)
    return dayNumber
  }
}
extension DailyData {
  static func placeholder(for date: Date)-> DailyData {
    // Provide a default instance of DailyData
    // Modify this according to your struct's properties
    return DailyData(id: UUID(), date: date, selectedButtons: [], foodDescription: "", dayDescription: "", mood: "")
  }
}
