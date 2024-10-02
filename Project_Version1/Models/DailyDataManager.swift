//
//  DailyDataManager.swift
//  Project_Version1
//
//  Created by Pro on 10/31/23.
//

import Foundation
import Combine

class DailyDataManager: ObservableObject {
  static let shared = DailyDataManager() // Singleton instance
  
  @Published var dailyEntries: [DailyData] = [] {
    didSet {
      saveToUserDefaults()
    }
  }
  
  private let userDefaultsKey = "dailyEntries"
  
  //Sample Cases
  func createSampleData() {
      let sampleEntries = [
          DailyData(id: UUID(), date: Date().addingTimeInterval(-86400 * 4), selectedButtons: [1], foodDescription: "Salad and grilled chicken", dayDescription: "Had a productive day at work", mood: "happy"),
          DailyData(id: UUID(), date: Date().addingTimeInterval(-86400 * 3), selectedButtons: [0], foodDescription: "Pasta and garlic bread", dayDescription: "Relaxed at home, watched a movie", mood: "sad"),
          DailyData(id: UUID(), date: Date().addingTimeInterval(-86400 * 2), selectedButtons: [3], foodDescription: "Fish and vegetables", dayDescription: "Went for a run in the park", mood: "neutral"),
          DailyData(id: UUID(), date: Date().addingTimeInterval(-86400 * 1), selectedButtons: [2], foodDescription: "Homemade pizza", dayDescription: "Game night with friends", mood: "semihappy"),
          DailyData(id: UUID(), date: Date().addingTimeInterval(-86400 * 5), selectedButtons: [4], foodDescription: "Burgers and fries", dayDescription: "Chill day, did some reading", mood: "semisad")
      ]
      dailyEntries = sampleEntries
  }

  init() {
    loadFromUserDefaults()
    
    //Enable for Sample Cases
    if dailyEntries.isEmpty {
      createSampleData()
      saveToUserDefaults()
    }
    
    
    
  }
  
  private func saveToUserDefaults() {
    if let data = try? JSONEncoder().encode(dailyEntries) {
      UserDefaults.standard.setValue(data, forKey: userDefaultsKey)
    }
  }
  
  private func loadFromUserDefaults() {
    guard let data = UserDefaults.standard.data(forKey: userDefaultsKey),
          let entries = try? JSONDecoder().decode([DailyData].self, from: data) else {
      return
    }
    dailyEntries = entries
  }
  
  func save(entry: DailyData) {
    // Check if there's already an entry for the given day
    if let index = dailyEntries.firstIndex(where: { Calendar.current.startOfDay(for: $0.date) == Calendar.current.startOfDay(for: entry.date) }) {
      // Replace the existing entry
      dailyEntries[index] = entry
    } else {
      // Append the new entry
      dailyEntries.append(entry)
    }
  }
  
  func fetchEntry(for date: Date) -> DailyData? {
    let startOfDay = Calendar.current.startOfDay(for: date)
    return dailyEntries.first(where: { Calendar.current.startOfDay(for: $0.date) == startOfDay })
  }
  func hasEntryForToday() -> Bool {
    return fetchEntry(for: Date()) != nil
  }
  // Keys for the high scores
  private let mashHighScoreKey = "mashHighScore"
  private let dotHighScoreKey = "dotHighScore"
  
  // Get the high score for Mash
  func getMashHighScore() -> Int {
    return UserDefaults.standard.integer(forKey: mashHighScoreKey)
  }
  
  // Get the high score for Dot
  func getDotHighScore() -> Int {
    return UserDefaults.standard.integer(forKey: dotHighScoreKey)
  }
  
  // Set a new high score for Mash if it's higher than the current high score
  func updateMashHighScore(newScore: Int) {
    let currentHighScore = getMashHighScore()
    if newScore > currentHighScore {
      UserDefaults.standard.set(newScore, forKey: mashHighScoreKey)
    }
  }
  
  // Set a new high score for Dot if it's higher than the current high score
  func updateDotHighScore(newScore: Int) {
    let currentHighScore = getDotHighScore()
    if newScore > currentHighScore {
      UserDefaults.standard.set(newScore, forKey: dotHighScoreKey)
    }
  }
  func clearUserDefaults() {
      UserDefaults.standard.removeObject(forKey: userDefaultsKey)
  }
}
