//
//  DaySheet.swift
//  Project_Version1
//
//  Created by Pro on 10/7/23.
//

import SwiftUI

struct DaySheet: View {
  
  @EnvironmentObject var dailyDataManager: DailyDataManager
  @Binding var mood: String
  @State private var EatText: String = ""
  @State private var MoreText: String = ""
  @State private var selectedButtons: Set<Int> = []
  
  @State private var weatherButtons: [ButtonData] = [
    ButtonData(index: 0, imageName: "Sunny", activeImageName: "Sunnyactive", buttonName: "Sunny"),
    ButtonData(index: 1, imageName: "Cloudy", activeImageName: "Cloudyactive", buttonName: "Cloudy"),
    ButtonData(index: 2, imageName: "Rainy", activeImageName: "Rainyactive", buttonName: "Rainy"),
    ButtonData(index: 3, imageName: "Hot", activeImageName: "Hotactive", buttonName: "Hot"),
    ButtonData(index: 4, imageName: "Cold", activeImageName: "Coldactive", buttonName: "Cold"),
  ]
  @State private var activity1Buttons: [ButtonData] = [
    ButtonData(index: 5, imageName: "Work", activeImageName: "Workactive", buttonName: "Work"),
    ButtonData(index: 6, imageName: "Exercise", activeImageName: "Exerciseactive", buttonName: "Exercise"),
    ButtonData(index: 7, imageName: "Game", activeImageName: "Gameactive", buttonName: "Game"),
    ButtonData(index: 8, imageName: "Sport", activeImageName: "Sportactive", buttonName: "Sport"),
    ButtonData(index: 9, imageName: "Study", activeImageName: "Studyactive", buttonName: "Study"),
  ]
  @State private var activity2Buttons: [ButtonData] = [
    ButtonData(index: 10, imageName: "Clean", activeImageName: "Cleanactive", buttonName: "Clean"),
    ButtonData(index: 11, imageName: "Date", activeImageName: "Dateactive", buttonName: "Date"),
    ButtonData(index: 12, imageName: "Family", activeImageName: "Familyactive", buttonName: "Family"),
    ButtonData(index: 13, imageName: "Friends", activeImageName: "Friendsactive", buttonName: "Friends"),
    ButtonData(index: 14, imageName: "Chill", activeImageName: "Chillactive", buttonName: "Chill"),
  ]
  @State private var activity3Buttons: [ButtonData] = [
    ButtonData(index: 15, imageName: "Cook", activeImageName: "Cookactive", buttonName: "Cook"),
    ButtonData(index: 16, imageName: "Vacation", activeImageName: "Vacationactive", buttonName: "Vacation"),
    ButtonData(index: 17, imageName: "Travel", activeImageName: "Travelactive", buttonName: "Travel"),
    ButtonData(index: 18, imageName: "Shop", activeImageName: "Shopactive", buttonName: "Shop"),
    ButtonData(index: 19, imageName: "Beauty", activeImageName: "Beautyactive", buttonName: "Beauty"),
  ]
  
  let date = Date()
  
  var body: some View {
    ZStack{
      Color("Offwhite")
        .ignoresSafeArea()
      ScrollView {
        VStack{
          Divider()
          Text("How was the weather?")
            .padding()
          HStack{
            ForEach(weatherButtons, id: \.index) { data in
              VStack {
                ButtonView(data: data, isSelected: selectedButtons.contains(data.index))
                  .onTapGesture {
                    if selectedButtons.contains(data.index) {
                      selectedButtons.remove(data.index)
                    } else {
                      selectedButtons.insert(data.index)
                    }
                  }
                Text(data.buttonName)
                  .font(.system(size: 16, weight: .semibold))
              }
            }
          }
          Text("What did you do?")
            .padding()
          VStack{
            HStack{
              ForEach(activity1Buttons, id: \.index) { data in
                VStack {
                  ButtonView(data: data, isSelected: selectedButtons.contains(data.index))
                    .onTapGesture {
                      if selectedButtons.contains(data.index) {
                        selectedButtons.remove(data.index)
                      } else {
                        selectedButtons.insert(data.index)
                      }
                    }
                  Text(data.buttonName)
                    .font(.system(size: 16, weight: .semibold))
                }
              }
            }
            HStack{
              ForEach(activity2Buttons, id: \.index) { data in
                VStack {
                  ButtonView(data: data, isSelected: selectedButtons.contains(data.index))
                    .onTapGesture {
                      if selectedButtons.contains(data.index) {
                        selectedButtons.remove(data.index)
                      } else {
                        selectedButtons.insert(data.index)
                      }
                    }
                  Text(data.buttonName)
                    .font(.system(size: 16, weight: .semibold))
                }
              }
            }
            /*HStack{
             ForEach(activity3Buttons, id: \.index) { data in
             VStack {
             ButtonView(data: data, isSelected: selectedButtons.contains(data.index))
             .onTapGesture {
             if selectedButtons.contains(data.index) {
             selectedButtons.remove(data.index)
             } else {
             selectedButtons.insert(data.index)
             }
             }
             Text(data.buttonName)
             .font(.system(size: 16, weight: .semibold))
             }
             }
             }*/
          }
          Text("What did you eat? \(Image(systemName: "pencil.line"))")
            .padding()
          TextField("Enter here...", text: $EatText, axis: .vertical)
            .textFieldStyle(CustomTextFieldStyle())
            .font(.system(size: 15, weight: .semibold))
            .padding(.horizontal)
          Text("Tell me more \(Image(systemName: "pencil.line"))")
            .padding()
          TextField("Enter here...", text: $MoreText, axis: .vertical)
            .textFieldStyle(CustomTextFieldStyle())
            .font(.system(size: 15, weight: .semibold))
            .padding(.horizontal)
          Spacer()
          Button(action: saveData){
            Image(systemName:"arrow.right.circle.fill")
              .resizable()
              .frame(width:70, height:70)
              .foregroundColor(Color("Green"))
          }
          .padding()
          Spacer()
        }
        .font(.system(size: 20))
        .fontWeight(.bold)
        .foregroundColor(Color("Green"))
      }
    }
    .navigationTitle(Text(date.formatted(.dateTime.day().month(.wide).year())))
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        NavigationLink(destination: ContentView()){
          Text("Done")
        }
      }
    }
  }
  private func saveData() {
      let dailyData = DailyData(
          id: UUID(), // Generate a unique ID
          date: date,
          selectedButtons: Array(selectedButtons),
          foodDescription: EatText,
          dayDescription: MoreText,
          mood: mood // Replace this with actual input
      )

    dailyDataManager.save(entry: dailyData)
  }
}

struct ButtonData: Identifiable {
    let id = UUID()
    let index: Int
    let imageName: String
    let activeImageName: String
    let buttonName: String
}

struct ButtonView: View {
    
    let data: ButtonData
    let isSelected: Bool
    
    var body: some View{
        
        VStack {
            Image(isSelected ? data.activeImageName : data.imageName)
                .frame(width:50, height:50)
        }
        .frame(width:65)
    }
}
