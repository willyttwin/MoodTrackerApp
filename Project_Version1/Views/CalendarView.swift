//
//  CalendarView.swift
//  Project_Version1
//
//  Created by Pro on 10/10/23.
//

import SwiftUI

struct CalendarView: View {
  
  @State private var isMovingRight = false
  @State private var isBooVisible = false
  @State private var isVisible = false
  @State private var showingDatePicker: Bool = false
  
  let centerX = UIScreen.main.bounds.width / 2
  @State var currentDate: Date = Date()
  
  @StateObject private var dataManager = DailyDataManager()

  private var daysInMonth: [Date] {
      guard let range = Calendar.current.range(of: .day, in: .month, for: currentDate) else { return [] }
      return Array(range).compactMap {
          Calendar.current.date(byAdding: .day, value: $0-1, to: startOfMonth(date: currentDate))
      }
  }
  
  var body: some View {
    
    GeometryReader { geometry in
      let isLandscape = geometry.size.width > geometry.size.height
      
      if isLandscape {
        // UI for landscape mode
        landscapeView(geometry: geometry)
      } else {
        // UI for portrait mode
        portraitView(geometry: geometry)
      }
    }
    
    
    
  }
  private func landscapeView(geometry: GeometryProxy) -> some View {
    ZStack {
      Color("Offwhite")
        .ignoresSafeArea()
      HStack{
        Rectangle()
          .fill(Color("Green"))
          .frame(width: geometry.size.width * 0.5, height: geometry.size.height * 1.1)
          .aspectRatio(contentMode:.fit)
          .ignoresSafeArea()
        Spacer()
      }
      HStack{
        Rectangle()
          .fill(Color("Green"))
          .frame(width: geometry.size.width * 0.6, height: geometry.size.height * 1.1)
          .aspectRatio(contentMode:.fit)
        Spacer()
      }
      Circle()
        .fill(Color("Green"))
        .opacity(0.4)
        .frame(width: 900, height: 900)
        .position(x: geometry.size.width / 2, y:UIScreen.main.bounds.height + 210)
      HStack {
        
        Spacer()
        VStack{
          
          //Calendar
          
          ZStack {
            RoundedRectangle(cornerRadius: 15)
              .fill(Color("Gray"))
              .shadow(radius: 2,x:0,y:4)
              .frame(width:390,height:280)
            VStack {
              HStack{
                Button(action: previousMonth) {
                  Image(systemName: "chevron.left")
                    .resizable()
                    .frame(width: 15, height: 20)
                    .foregroundStyle(Color(.black))
                }
                Text("\(currentDate.formatted(.dateTime.month(.wide).year()))")
                  .font(.system(size: 20,weight:.bold))
                  .frame(width:200)
                Button(action: nextMonth) {
                  Image(systemName: "chevron.right")
                    .resizable()
                    .frame(width: 15, height: 20)
                    .foregroundStyle(Color(.black))
                }
                
              }
              HStack {
                ForEach(0..<7) { index in
                  Text(weekdayName(index: index))
                    .font(.system(size: 20, weight:.bold))
                    .frame(maxWidth: 40)
                }
              }
              ForEach(Array(2..<6), id: \.self) { week in
                HStack(spacing:20) {
                  ForEach(Array(0..<7), id: \.self) { weekday in
                    if let day = dateInCurrentMonthFor(week: week, weekday: weekday) {
                      CalendarDayView(date: day, isCurrentMonth: true, dailyData: dataManager.fetchEntry(for: day))
                    } else {
                      let adjacentDate = dateInAdjacentMonthFor(week: week, weekday: weekday)
                      CalendarDayView(date: adjacentDate, isCurrentMonth: false, dailyData: dataManager.fetchEntry(for: adjacentDate))
                    }
                  }
                }
              }
            }
          } //Calendar ZStack end
          
          
          Spacer()
          
        }
        Spacer().frame(width:geometry.size.width * 0.6)
      }
      Image("Boo")
        .offset(x: isBooVisible ? geometry.size.width * 0.03 : -geometry.size.width, y:0)
        .offset(x: isMovingRight ? geometry.size.width * 0.06 : geometry.size.width * 0.1)
        .onAppear(){
          DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
            withAnimation(.easeInOut(duration: 2)) {
              isBooVisible = true
            }
            withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
              self.isMovingRight = true
            }
          }
        }
      Text("Let's see how you've been feeling")
        .multilineTextAlignment(.center)
        .padding()
        .background(Color("DarkGray"))
        .foregroundStyle(.black)
        .clipShape(RoundedRectangle(cornerRadius: 10, style:.continuous))
        .overlay(alignment: .bottomLeading) {
          Image(systemName: "arrowtriangle.down.fill")
            .font(.title)
            .rotationEffect(.degrees(66))
            .offset(x:-17,y:7)
            .foregroundStyle(Color("DarkGray"))
        }
        .frame(maxWidth:240)
        .offset(x:geometry.size.width * 0.3,y:geometry.size.height * -0.2)
        .opacity(isVisible ? 1 : 0)
        .onAppear {
          DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation(.easeIn(duration: 2)) {
              isVisible = true
            }
          }
        }
      
    }
  }
  
  private func portraitView(geometry: GeometryProxy) -> some View {
    ZStack {
      Color("Offwhite")
        .ignoresSafeArea()
      Ellipse()
        .fill(Color("Green"))
        .frame(width: 500, height: 300)
        .position(x: centerX, y:-80)
        .shadow(radius: 5, x:0, y:4)
      Circle()
        .fill(Color("Green"))
        .opacity(0.4)
        .frame(width: 900, height: 900)
        .position(x: centerX, y:UIScreen.main.bounds.height + 210)
      VStack{
        Spacer().frame(height:geometry.size.height * 0.27)
        ZStack {
          RoundedRectangle(cornerRadius: 15)
            .fill(Color("Gray"))
            .shadow(radius: 2,x:0,y:4)
            .frame(width:370,height:390)
          VStack {
            HStack{
              Button(action: previousMonth) {
                      Image(systemName: "chevron.left")
                          .resizable()
                          .frame(width: 15, height: 20)
                          .foregroundStyle(Color(.black))
                  }
              Text("\(currentDate.formatted(.dateTime.month(.wide).year()))")
                .font(.system(size: 20,weight:.bold))
                .frame(width:200)
              Button(action: nextMonth) {
                      Image(systemName: "chevron.right")
                          .resizable()
                          .frame(width: 15, height: 20)
                          .foregroundStyle(Color(.black))
                  }
              
            }
            HStack {
              ForEach(0..<7) { index in
                Text(weekdayName(index: index))
                  .font(.system(size: 20, weight:.bold))
                  .frame(maxWidth: 40)
              }
            }
            .padding(.vertical, 4)
            ForEach(Array(0..<6), id: \.self) { week in
              HStack(spacing:20) {
                ForEach(Array(0..<7), id: \.self) { weekday in
                  if let day = dateInCurrentMonthFor(week: week, weekday: weekday) {
                    CalendarDayView(date: day, isCurrentMonth: true, dailyData: dataManager.fetchEntry(for: day))
                  } else {
                    let adjacentDate = dateInAdjacentMonthFor(week: week, weekday: weekday)
                    CalendarDayView(date: adjacentDate, isCurrentMonth: false, dailyData: dataManager.fetchEntry(for: adjacentDate))
                  }
                }
              }
            }
          }
        }
        Spacer()
      }
      Image("Boo")
        .offset(x: isBooVisible ? 0 : -UIScreen.main.bounds.width, y:geometry.size.height * -0.3)
        .offset(x: isMovingRight ? -110 : -130)
        .onAppear(){
          DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
            withAnimation(.easeInOut(duration: 2)) {
              isBooVisible = true
            }
            withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
              self.isMovingRight = true
            }
          }
        }
      Text("Let's see how you've been feeling")
        .multilineTextAlignment(.center)
        .padding()
        .background(Color("DarkGray"))
        .foregroundStyle(.black)
        .clipShape(RoundedRectangle(cornerRadius: 10, style:.continuous))
        .overlay(alignment: .bottomLeading) {
          Image(systemName: "arrowtriangle.down.fill")
            .font(.title)
            .rotationEffect(.degrees(66))
            .offset(x:-17,y:7)
            .foregroundStyle(Color("DarkGray"))
        }
        .frame(maxWidth:240)
        .offset(x:50,y:geometry.size.height * -0.34)
        .opacity(isVisible ? 1 : 0)
        .onAppear {
          DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation(.easeIn(duration: 2)) {
              isVisible = true
            }
          }
        }
      
    }
  }
  func previousMonth() {
    
      if let newDate = Calendar.current.date(byAdding: .month, value: -1, to: currentDate) {
          currentDate = newDate
      }
  }

  func nextMonth() {
      if let newDate = Calendar.current.date(byAdding: .month, value: 1, to: currentDate) {
          currentDate = newDate
      }
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
    let startWeekday = Calendar.current.component(.weekday, from: startOfMonth(date: currentDate)) - 1
    let dayOffset = week * 7 + weekday - startWeekday
    if dayOffset < 0 || dayOffset >= daysInMonth.count {
      return nil
    }
    return daysInMonth[dayOffset]
  }
  
  private func dateInAdjacentMonthFor(week: Int, weekday: Int) -> Date {
    let startWeekday = Calendar.current.component(.weekday, from: startOfMonth(date: currentDate)) - 1
    let dayOffset = week * 7 + weekday - startWeekday
    if dayOffset < 0 {
      return Calendar.current.date(byAdding: .day, value: dayOffset, to: startOfMonth(date: currentDate))!
    } else {
      return Calendar.current.date(byAdding: .day, value: dayOffset - daysInMonth.count + 1, to: daysInMonth.last!)!
    }
  }
}

struct CalendarView_Previews: PreviewProvider {
  static var previews: some View {
    CalendarView()
  }
}
