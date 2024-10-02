//
//  StatsView.swift
//  Project_Version1
//
//  Created by Pro on 10/10/23.
//

import SwiftUI
/*
struct StatsView: View {
  @ObservedObject var dataManager: DailyDataManager = DailyDataManager()

    let moods = ["sad", "semisad", "neutral", "semihappy", "happy"]

    var body: some View {
        VStack {
            Text("Total Entries: \(dataManager.dailyEntries.count)")
                .padding()

            // Mood stats
            let moodCounts = countMoods()
          HStack{
            ForEach(moods, id: \.self) { mood in
              VStack {
                Image(mood)
                Text("\(moodCounts[mood] ?? 0)")
              }
            }
          }

            // Button stats
            let buttonCounts = countButtonSelections()
            ForEach(buttonCounts.keys.sorted(), id: \.self) { button in
                HStack {
                    Text("Button \(button):")
                    Spacer()
                    Text("\(buttonCounts[button] ?? 0)")
                }
            }
        }
        .padding()
    }
*/
struct StatsView: View {
  @ObservedObject var dataManager: DailyDataManager = DailyDataManager()
  
  let moods = ["sad", "semisad", "neutral", "semihappy", "happy"]
  let centerX = UIScreen.main.bounds.width / 2
  @State private var isMovingRight = false
  @State private var isBooVisible = false
  @State private var isVisible = false
  
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
          .frame(width: geometry.size.width * 0.55, height: geometry.size.height * 1.1)
          .aspectRatio(contentMode:.fit)
        Spacer()
      }
      Circle()
        .fill(Color("Green"))
        .opacity(0.4)
        .frame(width: 900, height: 900)
        .position(x: geometry.size.width / 2, y:UIScreen.main.bounds.height + 210)
      HStack {
        VStack {
          Spacer().frame(maxHeight:30)
          ScrollView{
            VStack{
              
              Spacer().frame(maxHeight:0)
              VStack(spacing: 20) {
                ZStack {
                  RoundedRectangle(cornerRadius: 20)
                    .fill(Color("Gray"))
                    .shadow(radius:4,x:0,y:4)
                    .frame(width:370,height:90)
                  let moodCounts = countMoods()
                  VStack{
                    Text("Mood Count")
                      .frame(maxWidth:330,alignment:.leading)
                      .font(.system(size: 20,weight:.bold))
                      .foregroundStyle(Color("Green"))
                    Spacer().frame(height:0)
                    HStack(spacing:24){
                      ForEach(moods, id: \.self) { mood in
                        VStack {
                          Image(mood)
                          Spacer().frame(height:0)
                          Text("\(moodCounts[mood] ?? 0)")
                        }
                      }
                    }
                  }
                }
                ZStack {
                  RoundedRectangle(cornerRadius: 20)
                    .fill(Color("Gray"))
                    .shadow(radius:4,x:0,y:4)
                    .frame(width:370,height:90)
                  VStack{
                    Text("Total Entry Count")
                      .frame(maxWidth:330,alignment:.leading)
                      .font(.system(size: 20,weight:.bold))
                      .foregroundStyle(Color("Green"))
                    Spacer()
                    Text("\(dataManager.dailyEntries.count)")
                      .frame(maxWidth:330,alignment:.leading)
                      .font(.system(size: 20,weight:.bold))
                    Spacer()
                  }
                }
                let mashHighScore = dataManager.getMashHighScore()
                let dotHighScore = dataManager.getDotHighScore()
                ZStack {
                  RoundedRectangle(cornerRadius: 20)
                    .fill(Color("Gray"))
                    .shadow(radius:4,x:0,y:4)
                    .frame(width:370,height:90)
                  VStack{
                    Text("Button Mash Record")
                      .frame(maxWidth:330,alignment:.leading)
                      .font(.system(size: 20,weight:.bold))
                      .foregroundStyle(Color("Green"))
                    Spacer()
                    Text("\(mashHighScore)")
                      .frame(maxWidth:330,alignment:.leading)
                      .font(.system(size: 20,weight:.bold))
                    Spacer()
                  }
                }
                ZStack {
                  RoundedRectangle(cornerRadius: 20)
                    .fill(Color("Gray"))
                    .shadow(radius:4,x:0,y:4)
                    .frame(width:370,height:90)
                  VStack{
                    Text("Tap The Dot Record")
                      .frame(maxWidth:330,alignment:.leading)
                      .font(.system(size: 20,weight:.bold))
                      .foregroundStyle(Color("Green"))
                    Spacer()
                    Text("\(dotHighScore)")
                      .frame(maxWidth:330,alignment:.leading)
                      .font(.system(size: 20,weight:.bold))
                    Spacer()
                  }
                }
                
                Spacer().frame(height:100)
              }
            }
          }
        }
        Spacer()
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
      Text("Let's check out your stats!")
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
      Circle()
        .fill(Color("Green"))
        .opacity(0.4)
        .frame(width: 900, height: 900)
        .position(x: geometry.size.width / 2, y:UIScreen.main.bounds.height + 210)
      VStack {
        Spacer().frame(maxHeight:30)
        ScrollView{
          VStack{
            Spacer().frame(height:90)
            ZStack{
              Image("Boo")
                .offset(x: isBooVisible ? 0 : -UIScreen.main.bounds.width, y:-10)
                .offset(x: isMovingRight ? -120 : -140)
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
              Text("Let's check out your stats!")
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
                .offset(x:50,y:-30)
                .opacity(isVisible ? 1 : 0)
                .onAppear {
                  DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation(.easeIn(duration: 2)) {
                      isVisible = true
                    }
                  }
                }
            }
            Spacer().frame(maxHeight:0)
            VStack(spacing: 20) {
              ZStack {
                RoundedRectangle(cornerRadius: 20)
                  .fill(Color("Gray"))
                  .shadow(radius:4,x:0,y:4)
                  .frame(width:370,height:90)
                let moodCounts = countMoods()
                VStack{
                  Text("Mood Count")
                    .frame(maxWidth:330,alignment:.leading)
                    .font(.system(size: 20,weight:.bold))
                    .foregroundStyle(Color("Green"))
                  Spacer().frame(height:0)
                  HStack(spacing:24){
                    ForEach(moods, id: \.self) { mood in
                      VStack {
                        Image(mood)
                        Spacer().frame(height:0)
                        Text("\(moodCounts[mood] ?? 0)")
                      }
                    }
                  }
                }
              }
              ZStack {
                RoundedRectangle(cornerRadius: 20)
                  .fill(Color("Gray"))
                  .shadow(radius:4,x:0,y:4)
                  .frame(width:370,height:90)
                VStack{
                  Text("Total Entry Count")
                    .frame(maxWidth:330,alignment:.leading)
                    .font(.system(size: 20,weight:.bold))
                    .foregroundStyle(Color("Green"))
                  Spacer()
                  Text("\(dataManager.dailyEntries.count)")
                    .frame(maxWidth:330,alignment:.leading)
                    .font(.system(size: 20,weight:.bold))
                  Spacer()
                }
              }
              let mashHighScore = dataManager.getMashHighScore()
              let dotHighScore = dataManager.getDotHighScore()
              ZStack {
                RoundedRectangle(cornerRadius: 20)
                  .fill(Color("Gray"))
                  .shadow(radius:4,x:0,y:4)
                  .frame(width:370,height:90)
                VStack{
                  Text("Button Mash Record")
                    .frame(maxWidth:330,alignment:.leading)
                    .font(.system(size: 20,weight:.bold))
                    .foregroundStyle(Color("Green"))
                  Spacer()
                  Text("\(mashHighScore)")
                    .frame(maxWidth:330,alignment:.leading)
                    .font(.system(size: 20,weight:.bold))
                  Spacer()
                }
              }
              ZStack {
                RoundedRectangle(cornerRadius: 20)
                  .fill(Color("Gray"))
                  .shadow(radius:4,x:0,y:4)
                  .frame(width:370,height:90)
                VStack{
                  Text("Tap The Dot Record")
                    .frame(maxWidth:330,alignment:.leading)
                    .font(.system(size: 20,weight:.bold))
                    .foregroundStyle(Color("Green"))
                  Spacer()
                  Text("\(dotHighScore)")
                    .frame(maxWidth:330,alignment:.leading)
                    .font(.system(size: 20,weight:.bold))
                  Spacer()
                }
              }
              
              Spacer().frame(height:50)
            }
            Spacer()
          }
        }
      }
      Ellipse()
        .fill(Color("Green"))
        .frame(width: 500, height: 300)
        .position(x: geometry.size.width / 2, y:-80)
        .shadow(radius: 5, x:0, y:4)
    }
  }
  private func countMoods() -> [String: Int] {
    return dataManager.dailyEntries.reduce(into: [:]) { counts, entry in
      counts[entry.mood, default: 0] += 1
    }
  }
  
  private func countButtonSelections() -> [Int: Int] {
    var buttonCounts = [Int: Int]()
    for entry in dataManager.dailyEntries {
      for button in entry.selectedButtons {
        buttonCounts[button, default: 0] += 1
      }
    }
    return buttonCounts
  }
}

#Preview {
  StatsView()
}
