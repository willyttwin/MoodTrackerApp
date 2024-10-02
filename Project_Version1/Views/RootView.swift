//
//  RootView.swift
//  Project_Version1
//
//  Created by Pro on 11/1/23.
//

import SwiftUI

struct RootView: View {
  
  @StateObject private var dataManager = DailyDataManager()
  
  var body: some View {
    if dataManager.hasEntryForToday() {
      ContentView()
    } else {
      WelcomeView()
    }
  }
}

#Preview {
  RootView()

}
