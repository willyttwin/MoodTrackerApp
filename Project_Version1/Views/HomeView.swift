//
//  HomeView.swift
//  Project_Version1
//
//  Created by Pro on 10/7/23.
//

import SwiftUI

struct HomeView: View {
  
  let centerX = UIScreen.main.bounds.width / 2
  @State private var isMovingRight = false
  @State private var isBooVisible = false
  @State private var isVisible = false
  @State var showBreathView = false
  var currentDate: Date = Date()
  private var daysInMonth: [Date] {
    guard let range = Calendar.current.range(of: .day, in: .month, for: currentDate) else { return [] }
    return Array(range).compactMap {
      Calendar.current.date(byAdding: .day, value: $0-1, to: startOfMonth(date: currentDate))
    }
  }
  var body: some View {
    NavigationStack {
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
    }//NavigationView
    .tint(Color("Green"))
  }
    
private func landscapeView(geometry: GeometryProxy) -> some View {
  ZStack {
    Color("Offwhite")
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
        .frame(width: geometry.size.width * 0.5, height: geometry.size.height * 1.1)
        .aspectRatio(contentMode:.fit)
      Spacer()
    }
    Circle()
      .fill(Color("Green"))
      .opacity(0.4)
      .frame(width: 900, height: 900)
      .position(x: geometry.size.width / 2, y:UIScreen.main.bounds.height + 210)
    HStack {
      
      
      
      //Left side of HStack
      Spacer()
      VStack {
        Text(currentDate.formatted(.dateTime.day().month(.wide).year()))
          .font(.title)
          .multilineTextAlignment(.center)
          .frame(width: 350, height:90)
          .fontWeight(.bold)
        //.background(.black)
          .foregroundColor(Color("Offwhite"))
        Spacer().frame(maxHeight:20)
        ZStack{
          RoundedRectangle(cornerRadius: 10)
            .fill(Color("Gray"))
            .frame(width: 350, height:70)
            .shadow(radius:3, x:0, y:4)
          VStack{
            HStack {
              ForEach(0..<7) { index in
                VStack {
                  Text(weekdayName(index: index))
                    .font(.system(size: 20, weight:.semibold))
                    .frame(maxWidth: 40)
                  Spacer().frame(height:0)
                }
              }
            }
            WeekView()
              .frame(width:330)
          }
        }
        Spacer()
      }

      
      
      
      //Right side of HStack
      
      Spacer()
      VStack {
        Text("Do some activities with Boo!")
          .font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/)
          .foregroundColor(Color("Green"))
          .fontWeight(.bold)
        NavigationLink(destination: BreathView()){
          ZStack{
            Rectangle()
              .fill(Color("Green"))
              .frame(width: 360, height:57)
              .cornerRadius(10)
              .shadow(radius:5, x:0, y:4)
            Text("Breathing Exercise")
              .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
              .foregroundColor(Color("Offwhite"))
              .fontWeight(.bold)
          }
        }
        .padding([.leading, .trailing])
        NavigationLink(destination:MashView()) {
          ZStack{
            Rectangle()
              .fill(Color("Green"))
              .frame(width: 360, height:57)
              .cornerRadius(10)
              .shadow(radius:5, x:0, y:4)
            Text("Button Mash")
              .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
              .foregroundColor(Color("Offwhite"))
              .fontWeight(.bold)
          }
        }
        .padding(/*@START_MENU_TOKEN@*/.horizontal/*@END_MENU_TOKEN@*/)
        NavigationLink(destination: DotView()) {
          ZStack{
            Rectangle()
              .fill(Color("Green"))
              .frame(width: 360, height:57)
              .cornerRadius(10)
              .shadow(radius:5, x:0, y:4)
            Text("Tap The Dot")
              .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
              .foregroundColor(Color("Offwhite"))
              .fontWeight(.bold)
          }
        }
        .padding(/*@START_MENU_TOKEN@*/.horizontal/*@END_MENU_TOKEN@*/)
        Spacer()
      }
      Spacer()
    }
    Image("Boo")
      .offset(x: isBooVisible ? geometry.size.width * -0.54 : -UIScreen.main.bounds.width, y:geometry.size.height * 0.1)
      .offset(x: isMovingRight ? geometry.size.width * 0.07 : geometry.size.width * 0.05)
      .onAppear(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
          withAnimation(.easeInOut(duration: 1.5)) {
            isBooVisible = true
          }
          withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
            self.isMovingRight = true
          }
        }
      }
    Group {
      Text("\"The secret of getting ahead is getting started.\" —Mark Twain")
        .padding()
        .background(Color("DarkGray"))
        .foregroundStyle(.black)
        .clipShape(RoundedRectangle(cornerRadius: 16, style:.continuous))
        .overlay(alignment: .bottomLeading) {
          /*Image(systemName: "arrowtriangle.down.fill")
            .font(.title)
            .rotationEffect(.degrees(45))
            .offset(x:-10,y:10)
            .foregroundStyle(Color("DarkGray"))*/
        }
        .frame(maxWidth:300)
    }
    .offset(x:geometry.size.width * -0.225,y:geometry.size.height * 0.1)
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
      Ellipse()
        .fill(Color("Green"))
        .frame(width: geometry.size.width * 2, height: geometry.size.height * 1.0)

        .position(x: geometry.size.width / 2, y:geometry.size.height * -0.35)
        .shadow(radius: 3, x:0, y:2)
      Circle()
        .fill(Color("Green"))
        .opacity(0.4)
        .frame(width: 900, height: 900)
        .position(x: geometry.size.width / 2, y:geometry.size.height + 210)
      VStack {
        Text(currentDate.formatted(.dateTime.day().month(.wide).year()))
          .font(.title)
          .multilineTextAlignment(.center)
          .frame(width: 350, height:90)
          .fontWeight(.bold)
        //.background(.black)
          .foregroundColor(Color("Offwhite"))
        Spacer().frame(maxHeight:40)
        ZStack{
          RoundedRectangle(cornerRadius: 10)
            .fill(Color("Gray"))
            .frame(width: 350, height:70)
            .shadow(radius:3, x:0, y:4)
          VStack{
            HStack {
              ForEach(0..<7) { index in
                VStack {
                  Text(weekdayName(index: index))
                    .font(.system(size: 20, weight:.semibold))
                    .frame(maxWidth: 40)
                  Spacer().frame(height:0)
                }
              }
            }
            WeekView()
              .frame(width:330)
          }
        }
        Spacer()
        Text("Do some activities with Boo!")
          .font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/)
          .foregroundColor(Color("Green"))
          .fontWeight(.bold)
        NavigationLink(destination: BreathView()){
          ZStack{
            Rectangle()
              .fill(Color("Green"))
              .frame(width: 360, height:57)
              .cornerRadius(10)
              .shadow(radius:5, x:0, y:4)
            Text("Breathing Exercise")
              .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
              .foregroundColor(Color("Offwhite"))
              .fontWeight(.bold)
          }
        }
        .padding([.leading, .trailing])
        NavigationLink(destination:MashView()) {
          ZStack{
            Rectangle()
              .fill(Color("Green"))
              .frame(width: 360, height:57)
              .cornerRadius(10)
              .shadow(radius:5, x:0, y:4)
            Text("Button Mash")
              .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
              .foregroundColor(Color("Offwhite"))
              .fontWeight(.bold)
          }
        }
        .padding(/*@START_MENU_TOKEN@*/.horizontal/*@END_MENU_TOKEN@*/)
        NavigationLink(destination: DotView()) {
          ZStack{
            Rectangle()
              .fill(Color("Green"))
              .frame(width: 360, height:57)
              .cornerRadius(10)
              .shadow(radius:5, x:0, y:4)
            Text("Tap The Dot")
              .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
              .foregroundColor(Color("Offwhite"))
              .fontWeight(.bold)
          }
        }
        .padding(/*@START_MENU_TOKEN@*/.horizontal/*@END_MENU_TOKEN@*/)
        Spacer().frame(maxHeight:100)
        
      }
      Image("Boo")
        .offset(x: isBooVisible ? 0 : -UIScreen.main.bounds.width, y:-30)
        .offset(x: isMovingRight ? -130 : -150)
        .onAppear(){
          DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
            withAnimation(.easeInOut(duration: 1.5)) {
              isBooVisible = true
            }
            withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
              self.isMovingRight = true
            }
          }
        }
      Group {
        Text("\"The secret of getting ahead is getting started.\" —Mark Twain")
          .padding()
          .background(Color("DarkGray"))
          .foregroundStyle(.black)
          .clipShape(RoundedRectangle(cornerRadius: 16, style:.continuous))
          .overlay(alignment: .bottomLeading) {
            Image(systemName: "arrowtriangle.down.fill")
              .font(.title)
              .rotationEffect(.degrees(45))
              .offset(x:-10,y:10)
              .foregroundStyle(Color("DarkGray"))
          }
          .frame(maxWidth:300)
      }
      .offset(x:40,y:-100)
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

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
