//
//  DotView.swift
//  Project_Version1
//
//  Created by Pro on 10/10/23.
//

import SwiftUI

struct DotView: View {
  @ObservedObject var dataManager: DailyDataManager = DailyDataManager()
  @Environment(\.dismiss) var dismiss
  @State private var counter: Int = 0
  @State private var timeLeft: Double = 30.0
  @State private var isActive: Bool = true
  @State private var progress: CGFloat = 0.0
  @State private var position = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
  @State private var hasStarted: Bool = false
  
  let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
  
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
      Ellipse()
        .fill(Color("Green"))
        .frame(width: 500, height: 300)
        .position(x: UIScreen.main.bounds.width / 2, y:-80)
        .shadow(radius: 5, x:0, y:4)
      VStack {
        Spacer().frame(height:20)
        Button(action: {dismiss()}){
          Image(systemName: "house.fill")
            .font(.title2)
            .tint(Color("Offwhite"))
        }
        Spacer()
      }
      
      
      VStack {
        Spacer().frame(height:90)
        
        Image("Boo")
        Text("Tap the dots!")
          .font(.system(size: 33, weight: .bold))
          .foregroundStyle(Color("Green"))
        ProgressView(value: progress)
          .progressViewStyle(.linear)
          .frame(height: 10.0)
          .scaleEffect(x:1, y:2, anchor:.center)
          .clipShape(RoundedRectangle(cornerRadius: 6))
          .tint(Color("Green"))
        //If I want a timer
        //Text("\(String(format: "%.0f", timeLeft))s")
        Spacer()
        
        Text("\(counter)")
          .font(.system(size: 64,weight:.bold))
        
        
      }
      Circle()
        .fill(Color("Green"))
        .frame(width: 40, height: 40)
        .position(position)
        .onTapGesture {
          moveCircleToRandomPosition()
          counter += 1
        }
    }
    .padding()
    .onReceive(timer) { _ in
      if hasStarted && timeLeft > 0 {
        progress += 0.000333
        timeLeft -= 0.01
      } else if timeLeft <= 0 {
        isActive = false
        timer.upstream.connect().cancel()
      }
    }
    .onChange(of: isActive) { newValue in
      if !newValue {
        let newDotScore = counter
        dataManager.updateDotHighScore(newScore: newDotScore)
        dismiss()
      }
    }
    .toolbar(.hidden)
  }
  private func portraitView(geometry: GeometryProxy) -> some View {
    ZStack {
      Color("Offwhite")
        .ignoresSafeArea()
      Ellipse()
        .fill(Color("Green"))
        .frame(width: geometry.size.width * 1.2, height: geometry.size.height * 0.4)
        .position(x: geometry.size.width / 2, y:-80)
        .shadow(radius: 5, x:0, y:4)
      VStack {
        Spacer().frame(height:20)
        Button(action: {dismiss()}){
          Image(systemName: "house.fill")
            .font(.title2)
            .tint(Color("Offwhite"))
        }
        Spacer()
      }
      
      
      VStack {
        Spacer().frame(height:90)
        
        Image("Boo")
        Text("Tap the dots!")
          .font(.system(size: 33, weight: .bold))
          .foregroundStyle(Color("Green"))
        ProgressView(value: progress)
          .progressViewStyle(.linear)
          .frame(height: 10.0)
          .scaleEffect(x:1, y:2, anchor:.center)
          .clipShape(RoundedRectangle(cornerRadius: 6))
          .tint(Color("Green"))
          .padding()
        //If I want a timer
        //Text("\(String(format: "%.0f", timeLeft))s")
        Spacer()
        
        Text("\(counter)")
          .font(.system(size: 64,weight:.bold))
        
        
      }
      Circle()
        .fill(Color("Green"))
        .frame(width: 40, height: 40)
        .position(position)
        .onTapGesture {
          moveCircleToRandomPosition()
          counter += 1
        }
    }
    .onReceive(timer) { _ in
      if hasStarted && timeLeft > 0 {
        progress += 0.000333
        timeLeft -= 0.01
      } else if timeLeft <= 0 {
        isActive = false
        timer.upstream.connect().cancel()
      }
    }
    .onChange(of: isActive) { newValue in
      if !newValue {
        let newDotScore = counter
        dataManager.updateDotHighScore(newScore: newDotScore)
        dismiss()
      }
    }
    .toolbar(.hidden)
  }
  private func moveCircleToRandomPosition() {
    hasStarted = true
    let circleRadius: CGFloat = 40 // Half of the circle's width/height.
    
    let x = CGFloat.random(in: circleRadius..<(UIScreen.main.bounds.width - circleRadius - 20))
    
    let topQuarter = UIScreen.main.bounds.height * 0.30
    let y = CGFloat.random(in: (topQuarter + circleRadius)..<(UIScreen.main.bounds.height - circleRadius - 50))
    
    position = CGPoint(x: x, y: y)
  }
}

#Preview {
  DotView()
}
