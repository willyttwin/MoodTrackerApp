//
//  SplashView.swift
//  Project_Version1
//
//  Created by Pro on 11/2/23.
//

import SwiftUI

struct SplashView: View {
  
  @State var isActive: Bool = false
  
  var body: some View {
    ZStack {
      Color("Green")
        .ignoresSafeArea()
      if self.isActive {
          RootView()
      } else {
        Image("Icon")
          .resizable()
          .frame(width:200,height:200)
      }
    }
    .onAppear {
      DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        withAnimation {
          self.isActive = true
        }
      }
    }
  }
}

#Preview {
    SplashView()
}
