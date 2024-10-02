//
//  MashView.swift
//  Project_Version1
//
//  Created by Pro on 10/10/23.
//

import SwiftUI

struct MashView: View {
  @ObservedObject var dataManager: DailyDataManager = DailyDataManager()
  @State private var counter: Int = 0
  @State private var timeLeft: Double = 30.0
  @State private var isActive: Bool = true
  @State private var progress: CGFloat = 0.0
  @State private var hasStarted: Bool = false
  @Environment(\.dismiss) var dismiss
  
  
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
        Spacer().frame(height:60)
        Image("Boo")
        Text("Tap as fast as you can!")
          .font(.system(size:33,weight:.bold))
          .foregroundStyle(Color("Green"))
          .multilineTextAlignment(.center)
        ProgressView(value: progress)
          .progressViewStyle(.linear)
          .frame(height: 10.0)
          .scaleEffect(x:1, y:2, anchor:.center)
          .clipShape(RoundedRectangle(cornerRadius: 6))
          .tint(Color("Green"))
        //Text("\(String(format: "%.0f", timeLeft))s")
        Spacer()
        Image("punching bag")
        Spacer()
        
        Text("\(counter)")
          .font(.system(size: 64,weight: .bold))
      
        
        
      }
      .padding(25)
    }
    .contentShape(Rectangle())
    .onTapGesture {
      hasStarted = true
      counter += 1
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
        let newMashScore = counter
        dataManager.updateMashHighScore(newScore: newMashScore)
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
        Spacer().frame(height:60)
        Image("Boo")
        Text("Tap as fast as you can!")
          .font(.system(size:33,weight:.bold))
          .foregroundStyle(Color("Green"))
          .multilineTextAlignment(.center)
        ProgressView(value: progress)
          .progressViewStyle(.linear)
          .frame(height: 10.0)
          .scaleEffect(x:1, y:2, anchor:.center)
          .clipShape(RoundedRectangle(cornerRadius: 6))
          .tint(Color("Green"))
        //Text("\(String(format: "%.0f", timeLeft))s")
        Spacer()
        Image("punching bag")
        Spacer()
        
        Text("\(counter)")
          .font(.system(size: 64,weight: .bold))
      
        
        
      }
      .padding(25)
    }
    .contentShape(Rectangle())
    .onTapGesture {
      hasStarted = true
      counter += 1
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
        let newMashScore = counter
        dataManager.updateMashHighScore(newScore: newMashScore)
        dismiss()
      }
    }
    .toolbar(.hidden)
  }
}

#Preview {
  MashView()
}
