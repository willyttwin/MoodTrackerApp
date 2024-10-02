//
//  BreathView.swift
//  Project_Version1
//
//  Created by Pro on 10/10/23.
//

import SwiftUI
import Combine

struct BreathView: View {
  enum BreathPhase {
    case preStart
    case breatheIn
    case hold
    case breatheOut
  }
  
  @State private var currentPhase: BreathPhase = .preStart
  @State private var progress: CGFloat = 0.0
  @State private var cycleCount: Int = 0
  @State private var remainingTime: Double = 5.0 // Start with 5 seconds for pre-start
  @State private var BooPhase: String = "Boo"
  
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
      Rectangle()
        .fill(Color("Green"))
        .opacity(0.4)
        .frame(width: geometry.size.width * 1.2, height: geometry.size.height * 0.2)
        .position(x: geometry.size.width / 2, y:geometry.size.height * 1.05)
      Rectangle()
        .fill(Color("Green"))
        .frame(width:geometry.size.width*1.2, height: 300)
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
      VStack(spacing: 20) {
        Spacer()
        Spacer()
        Text(displayText(for: currentPhase))
          .font(.system(size: 32, weight: .bold))
          .foregroundStyle(Color("Green"))
        
        ProgressView(value: progress)
          .progressViewStyle(.linear)
          .frame(height: 10.0)
          .scaleEffect(x:1, y:2, anchor:.center)
          .clipShape(RoundedRectangle(cornerRadius: 6))
          .tint(Color("Green"))
        
        Text("\(String(format: "%.0f", remainingTime)) seconds left")
          .font(.title3)
        Spacer()
        
      }
      .padding(.horizontal,50)
      .onReceive(timer) { _ in
        switch currentPhase {
        case .preStart:
          BooPhase = "Boo"
          remainingTime -= 0.01
          if remainingTime <= 0 {
            startNextPhase()
          }
        case .breatheIn:
          BooPhase = "Breathing Boo"
          progress += 0.0025
          remainingTime -= 0.01
          if progress >= 1.0 {
            startNextPhase()
          }
        case .hold:
          BooPhase = "Hold breath Boo"
          progress += 0.0014
          remainingTime -= 0.01
          if progress >= 1.0 {
            startNextPhase()
          }
        case .breatheOut:
          BooPhase = "Breathing Boo"
          progress += 0.00125
          remainingTime -= 0.01
          if progress >= 1.0 {
            cycleCount += 1
            if cycleCount < 3 {
              startNextPhase()
            } else {
              dismiss()
            }
          }
        }
      }
      Image(BooPhase)
        .offset(y:geometry.size.height * -0.15)
    }
    .toolbar(.hidden)
  }
  private func portraitView(geometry: GeometryProxy) -> some View {
    ZStack {
      Color("Offwhite")
        .ignoresSafeArea()
      Ellipse()
        .fill(Color("Green"))
        .opacity(0.4)
        .frame(width: geometry.size.width * 1.2, height: geometry.size.height * 0.4)
        .position(x: geometry.size.width / 2, y:geometry.size.height * 1)
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
      VStack(spacing: 20) {
        Spacer()
        Text(displayText(for: currentPhase))
          .font(.system(size: 32, weight: .bold))
          .foregroundStyle(Color("Green"))
        
        ProgressView(value: progress)
          .progressViewStyle(.linear)
          .frame(height: 10.0)
          .scaleEffect(x:1, y:2, anchor:.center)
          .clipShape(RoundedRectangle(cornerRadius: 6))
          .tint(Color("Green"))
        
        Text("\(String(format: "%.0f", remainingTime)) seconds left")
          .font(.title3)
        Spacer()
        
      }
      .padding(.horizontal,50)
      .onReceive(timer) { _ in
        switch currentPhase {
        case .preStart:
          BooPhase = "Boo"
          remainingTime -= 0.01
          if remainingTime <= 0 {
            startNextPhase()
          }
        case .breatheIn:
          BooPhase = "Breathing Boo"
          progress += 0.0025
          remainingTime -= 0.01
          if progress >= 1.0 {
            startNextPhase()
          }
        case .hold:
          BooPhase = "Hold breath Boo"
          progress += 0.0014
          remainingTime -= 0.01
          if progress >= 1.0 {
            startNextPhase()
          }
        case .breatheOut:
          BooPhase = "Breathing Boo"
          progress += 0.00125
          remainingTime -= 0.01
          if progress >= 1.0 {
            cycleCount += 1
            if cycleCount < 3 {
              startNextPhase()
            } else {
              dismiss()
            }
          }
        }
      }
      Image(BooPhase)
        .offset(y:-90)
    }
    .toolbar(.hidden)
  }
  func startNextPhase() {
    progress = 0.0
    
    switch currentPhase {
    case .preStart:
      currentPhase = .breatheIn
      remainingTime = 4.0
    case .breatheIn:
      currentPhase = .hold
      remainingTime = 7.0
    case .hold:
      currentPhase = .breatheOut
      remainingTime = 8.0
    case .breatheOut:
      currentPhase = .breatheIn
      remainingTime = 4.0
    }
  }
  
  func displayText(for phase: BreathPhase) -> String {
    switch phase {
    case .preStart:
      return "Get Ready..."
    case .breatheIn:
      return "Breathe In"
    case .hold:
      return "Hold your breath"
    case .breatheOut:
      return "Breathe Out"
    }
  }
}

struct BreathView_Previews: PreviewProvider {
    static var previews: some View {
        BreathView()
    }
}
