//
//  MonthYearPicker.swift
//  Project_Version1
//
//  Created by Pro on 11/1/23.
//

import SwiftUI

struct MonthYearPicker: View {
    let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    let years = Array(1900...2100).map { "\($0)" }
    
    @State private var selectedMonth: String = "January"
    @State private var selectedYear: String = "2022"
    
    var body: some View {
        HStack {
            Picker("Month", selection: $selectedMonth) {
                ForEach(months, id: \.self) { month in
                    Text(month).tag(month)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(width: 150)
            
            Picker("Year", selection: $selectedYear) {
                ForEach(years, id: \.self) { year in
                    Text(year).tag(year)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(width: 100)
        }
    }
}
