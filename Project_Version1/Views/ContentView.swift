//
//  ContentView.swift
//  Project_Version1
//
//  Created by Pro on 10/7/23.
//

import SwiftUI

struct ContentView: View {
  
  @State var activeTab: Tab = .home
  @Namespace private var animation
  
  init() {
    UITabBar.appearance().isHidden = true
  }
  
  var body: some View {
    NavigationStack{
      ZStack(alignment: .bottom) {
        TabView(selection: $activeTab) {
          
          HomeView()
            .tag(Tab.home)
          //.toolbar(.hidden, for: .tabBar)
          StatsView()
            .tag(Tab.stats)
          //.toolbar(.hidden, for: .tabBar)
          CalendarView()
            .tag(Tab.calendar)
          //.toolbar(.hidden, for: .tabBar)
          SettingsView()
            .tag(Tab.settings)
          //.toolbar(.hidden, for: .tabBar)
        }
        CustomTabBar()
      }
    }
    .toolbar(.hidden)
    .tint(Color("Green"))
  }
  
  @ViewBuilder
  func CustomTabBar(_ tint: Color = Color("Green"), _ inactiveTint: Color = Color("Offwhite")) ->
  some View {
    HStack() {
      TabItem(tint: tint,
              inactiveTint: inactiveTint,
              tab: Tab.home,
              animation: animation,
              activeTab: $activeTab)
      TabItem(tint: tint,
              inactiveTint: inactiveTint,
              tab: Tab.stats,
              animation: animation,
              activeTab: $activeTab)
      /*ZStack {
       Rectangle()
       .fill(Color("Green"))
       .opacity(1)
       .frame(maxWidth:60,maxHeight:60)
       Image(systemName: "plus")
       .foregroundColor(Color("Offwhite"))
       .font(.largeTitle)
       .fontWeight(.black)
       }*/
      //Spacer().frame(width:80)
      TabItem(tint: tint,
              inactiveTint: inactiveTint,
              tab: Tab.calendar,
              animation: animation,
              activeTab: $activeTab)
      TabItem(tint: tint,
              inactiveTint: inactiveTint,
              tab: Tab.settings,
              animation: animation,
              activeTab: $activeTab)
    }
    /*.background(content: {
     RoundedRectangle(cornerRadius: 35)
     .strokeBorder(Color("Offwhite"),lineWidth:0)
     .background(RoundedRectangle(cornerRadius: 35).fill(Color("Offwhite")))
     .shadow(radius: 4,x:0,y:4)
     .frame(height:70)
     })*/
    
    .background(content: {
      ZStack{
        Rectangle()
          .fill(Color("Offwhite"))
          .frame(height:75)
          .shadow(color: .gray, radius:1, x: 0,y:-1)
          .offset(y:-1)
          .ignoresSafeArea()
        Rectangle()
          .fill(Color("Offwhite"))
          .frame(height:80)
          .ignoresSafeArea()
      }
      /*ZStack {
        Circle()
          .fill(Color("Offwhite"))
          .frame(width:70)
          .shadow(color: .gray, radius:1, x: 0,y:-1)
          .offset(y:-3)
        Circle()
          .fill(Color("Offwhite"))
        //.shadow(color: .green, radius:1, x: 0,y:-2)
        Image(systemName: "plus")
          .font(.system(size:50,weight: .semibold))
          .foregroundStyle(Color("Green"))
      }
      .frame(width:73, height:73)
      .offset(y:-25)
      .onTapGesture {
        //
      }*/
    })
    .background(Color("Offwhite"))
    
    //.padding(.horizontal, 15)
    //.padding(.vertical, 10)
    .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.3), value: activeTab)
  }
}
struct TabItem: View {
  var tint: Color
  var inactiveTint: Color
  var tab: Tab
  var animation: Namespace.ID
  @Binding var activeTab: Tab
  
  var body: some View {
    VStack{
      Image(tab.systemImage)
        .renderingMode(.template)
        .foregroundColor(activeTab == tab ? inactiveTint : tint)
        .frame(width: activeTab == tab ? 58 : 35, height: activeTab == tab ? 58 : 35)
        .background {
          if activeTab == tab {
            Circle()
              .fill(tint)
              .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
          }
        }
      Text(tab.rawValue)
        .font(.caption)
        .foregroundStyle(activeTab == tab ? tint : .gray)
    }
    .frame(maxWidth:.infinity)
    .contentShape(Rectangle())
    .onTapGesture {
      activeTab = tab
    }
  }
}
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
