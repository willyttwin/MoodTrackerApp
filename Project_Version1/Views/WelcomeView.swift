//
//  WelcomeView.swift
//  Project_Version1
//
//  Created by Pro on 10/7/23.
//

import SwiftUI


struct WelcomeView: View {
  
  @StateObject private var dataManager = DailyDataManager()
  @State private var isBooVisible = false
  @State private var isVisible = false
  @State private var isTopVisible = false
  @State private var isMovingRight = false
  @State private var isButtonVisible = false
  @State private var selectedButton: Int? = nil
  @State private var mood: String  = ""
  
  
  
  let date = Date()
  
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
    }
    .tint(Color("Green"))
  }
  
  
  
  
  
  private func landscapeView(geometry: GeometryProxy) -> some View {
   ZStack {
     Color("Offwhite")
       .ignoresSafeArea()
     Rectangle()
       .fill(Color("Green"))
       .frame(width: 1500, height: 150)
       .position(x: geometry.size.width / 2, y:geometry.size.height * 0.01)
       .shadow(radius: 2, x:0, y:4)
       .offset(y: isTopVisible ? 0 : -UIScreen.main.bounds.height)
       .onAppear(){
         DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
           withAnimation(.easeInOut(duration: 1.5)) {
             isTopVisible = true
           }
         }
       }
     VStack{
       Spacer().frame(maxHeight:30)
       Text(date.formatted(.dateTime.day().month(.wide).year()))
         .fontWeight(.bold)
         .font(.largeTitle)
         .foregroundColor(Color("Offwhite"))
         .offset(y: isTopVisible ? 0 : -UIScreen.main.bounds.height)
       Spacer()
     }
     
     VStack(){
       Spacer().frame(height: geometry.size.height * 0.35)
       Text(getTextForSelectedButton())
         .foregroundColor(Color("Green"))
         .font(.largeTitle)
         .fontWeight(.bold)
       Spacer().frame(height: geometry.size.height * 0.05)
       HStack(spacing:80){

         Button(action: Sad){
           Image(selectedButton == 0 ? "sadactive" : "bigsad")
             .animation(nil)
         }
         .frame(width:50,height:50)
         
         
         Button(action: Semisad){
           Image(selectedButton == 1 ? "semisadactive" : "bigsemisad")
             .animation(nil)
         }
         .frame(width:50,height:50)
         
         
         Button(action: Neutral) {
           Image(selectedButton == 2 ? "neutralactive" : "bigneutral")
             .animation(nil)
         }
         
         
         .frame(width:50,height:50)
         Button(action: Semihappy) {
           Image(selectedButton == 3 ? "semihappyactive" : "bigsemihappy")
             .animation(nil)
         }
         .frame(width:50,height:50)
         
         
         Button(action: Happy) {
           Image(selectedButton == 4 ? "happyactive" : "bighappy")
             .animation(nil)
         }
         .frame(width:50,height:50)
         
         
       }
       .frame(maxHeight:100, alignment: .top)
       .buttonStyle(TiltButtonStyle())
       
       .padding(.horizontal)
       Spacer().frame(maxHeight:130)
       if selectedButton != nil{
         NavigationLink(destination: DayDetailView(dailyData: getOrCreateDailyDataForToday())) {
           Image(systemName:"arrow.right.circle.fill")
             .resizable()
             .frame(width:70, height:70)
             .foregroundColor(Color("Green"))
         }
         .buttonStyle(ScaleButtonStyle())
         .onAppear {
           withAnimation(.easeIn(duration: 0.25)) {
             isButtonVisible = true
           }
         }
       } else {
         Spacer().frame(maxHeight:70)
       }
       Spacer().frame(maxHeight:80)
     }
     .opacity(isVisible ? 1 : 0)
     .onAppear {
       DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
         withAnimation(.easeIn(duration: 2)) {
           isVisible = true
         }
       }
     }
     Image("Boo")
       .offset(x: isBooVisible ? 0 : -UIScreen.main.bounds.width, y: geometry.size.height * -0.2)
       .offset(x: isMovingRight ? 10 : -10)
       .onAppear(){
         DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
           withAnimation(.easeInOut(duration: 2)) {
             isBooVisible = true
           }
           withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
             self.isMovingRight = true
           }
         }
       }
   }//ZStack
  }
  
  
  
  
  
  private func portraitView(geometry: GeometryProxy) -> some View {
    ZStack {
      Color("Offwhite")
        .ignoresSafeArea()
      Circle()
        .fill(Color("Green"))
        .frame(width: geometry.size.width * 4, height: geometry.size.height * 1.0)
        .position(x: geometry.size.width / 2, y:geometry.size.height * -0.3)
        .shadow(radius: 2, x:0, y:4)
        .offset(y: isTopVisible ? 0 : -UIScreen.main.bounds.height)
        .onAppear(){
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(.easeInOut(duration: 1.5)) {
              isTopVisible = true
            }
          }
        }
      VStack{
        Spacer().frame(maxHeight:50)
        Text(date.formatted(.dateTime.day().month(.wide).year()))
          .fontWeight(.bold)
          .font(.largeTitle)
          .foregroundColor(Color("Offwhite"))
          .offset(y: isTopVisible ? 0 : -UIScreen.main.bounds.height)
        Spacer()
      }
      
      VStack(){
        Spacer().frame(height: geometry.size.height * 0.4)
        Text(getTextForSelectedButton())
          .foregroundColor(Color("Green"))
          .font(.largeTitle)
          .fontWeight(.bold)
        Spacer().frame(height: geometry.size.height * 0.05)
        HStack(spacing: geometry.size.width*0.07){
          /*CustomStateButton(selectedButton: $selectedButton, buttonIndex: 0,
           unselectedImage: "bigsad",heldDownImage: "sadpressed", selectedImage: "sadactive")*/
          Button(action: Sad){
            Image(selectedButton == 0 ? "sadactive" : "bigsad")
              .animation(nil)
          }
          .frame(width:50,height:50)
          Button(action: Semisad){
            Image(selectedButton == 1 ? "semisadactive" : "bigsemisad")
              .animation(nil)
          }
          .frame(width:50,height:50)
          
          Button(action: Neutral) {
            Image(selectedButton == 2 ? "neutralactive" : "bigneutral")
              .animation(nil)
          }
          .frame(width:50,height:50)
          Button(action: Semihappy) {
            Image(selectedButton == 3 ? "semihappyactive" : "bigsemihappy")
              .animation(nil)
          }
          .frame(width:50,height:50)
          Button(action: Happy) {
            Image(selectedButton == 4 ? "happyactive" : "bighappy")
              .animation(nil)
          }
          .frame(width:50,height:50)
        }
        .frame(maxHeight:100, alignment: .top)
        .buttonStyle(TiltButtonStyle())
        
        .padding(.horizontal)
        Spacer().frame(maxHeight:130)
        if selectedButton != nil{
          NavigationLink(destination: DayDetailView(dailyData: getOrCreateDailyDataForToday())) {
            Image(systemName:"arrow.right.circle.fill")
              .resizable()
              .frame(width:70, height:70)
              .foregroundColor(Color("Green"))
          }
          .buttonStyle(ScaleButtonStyle())
          .onAppear {
            withAnimation(.easeIn(duration: 0.25)) {
              isButtonVisible = true
            }
          }
        } else {
          Spacer().frame(maxHeight:70)
        }
        Spacer().frame(maxHeight:80)
      }
      .opacity(isVisible ? 1 : 0)
      .onAppear {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
          withAnimation(.easeIn(duration: 2)) {
            isVisible = true
          }
        }
      }
      Image("Boo")
        .offset(x: isBooVisible ? 0 : -UIScreen.main.bounds.width, y:-100)
        .offset(x: isMovingRight ? 10 : -10)
        .onAppear(){
          DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation(.easeInOut(duration: 2)) {
              isBooVisible = true
            }
            withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
              self.isMovingRight = true
            }
          }
        }
    }//ZStack
  }
  func getOrCreateDailyDataForToday() -> DailyData {
    if let todayData = dataManager.fetchEntry(for: date) {
      let updatedEntry = DailyData(id: UUID(),
                                   date: todayData.date,
                                   selectedButtons: todayData.selectedButtons,
                                   foodDescription: todayData.foodDescription,
                                   dayDescription: todayData.dayDescription,
                                   mood: mood)
      return updatedEntry
    } else {
      // Create a new DailyData for today
      let newEntry = DailyData(id: UUID(), date: Date(), selectedButtons: [], foodDescription: "", dayDescription: "", mood: mood)
      return newEntry
    }
  }

  func Sad () {
    selectedButton = 0
    mood = "sad"
  }
  func Semisad () {
    selectedButton = 1
    mood = "semisad"
  }
  func Neutral () {
    selectedButton = 2
    mood = "neutral"
  }
  func Semihappy () {
    selectedButton = 3
    mood = "semihappy"
  }
  func Happy () {
    selectedButton = 4
    mood = "happy"
  }
  func getTextForSelectedButton() -> String {
    switch selectedButton {
    case 0:
      return "Awful?"
    case 1:
      return "Bad?"
    case 2:
      return "Meh?"
    case 3:
      return "Good?"
    case 4:
      return "Great?"
    default:
      return "How are you?"
    }
  }
}

#Preview {
  WelcomeView()
}
