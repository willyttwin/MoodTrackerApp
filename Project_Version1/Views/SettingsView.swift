//
//  SettingsView.swift
//  Project_Version1
//
//  Created by Pro on 10/10/23.
//

import SwiftUI

struct SettingsView: View {
  
  @State private var BoosMood = true
  @State private var Music = false
  @State private var DarkMode = false
  let centerX = UIScreen.main.bounds.width / 2
  
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
        .position(x: geometry.size.width / 2, y:-80)
        .shadow(radius: 5, x:0, y:4)
      Circle()
        .fill(Color("Green"))
        .opacity(0.4)
        .frame(width: 900, height: 900)
        .position(x: geometry.size.width / 2, y:UIScreen.main.bounds.height + 210)
      VStack(spacing:30){
        Spacer()
        ZStack{
          VStack{
            Color(.white)
              .frame(height:50)
            Spacer().frame(height:0)
            Divider()
          }
          Toggle(isOn: $BoosMood, label: {
            HStack {
              Image("BooSettings")
                .frame(width:35)
              Text("Boo's Mood")
            }
          })
        }
        ZStack{
          VStack{
            Color(.white)
              .frame(height:50)
            Spacer().frame(height:0)
            Divider()
          }
          Toggle(isOn: $Music, label: {
            HStack {
              Image(systemName:"speaker.wave.2.fill")
                .foregroundStyle(Color("Green"))
                .frame(width:35)
              Text("Music")
            }
          })
        }
        ZStack{
          VStack{
            Color(.white)
              .frame(height:50)
            Spacer().frame(height:0)
            Divider()
          }
          Toggle(isOn: $DarkMode, label: {
            HStack {
              Image(systemName:"moon.fill")
                .foregroundStyle(Color("Green"))
                .frame(width:35)
              Text("Dark Mode")
            }
          })
        }
        ZStack{
          VStack{
            Color(.white)
              .frame(height:50)
            Spacer().frame(height:0)
            Divider()
          }
          HStack {
            Image("Exerciseactive")
              .resizable()
              .frame(width:35,height:35)
            Text("Customize Activities")
            Spacer()
            Image(systemName: "chevron.right")
              .foregroundStyle(Color.gray)
          }
        }
        Spacer()
      }
      .padding()
    }
    .font(.system(size: 20))
  }
  private func portraitView(geometry: GeometryProxy) -> some View {
    ZStack {
      Color("Offwhite")
        .ignoresSafeArea()
      Ellipse()
        .fill(Color("Green"))
        .frame(width: 500, height: 300)
        .position(x: geometry.size.width / 2, y:-80)
        .shadow(radius: 5, x:0, y:4)
      Circle()
        .fill(Color("Green"))
        .opacity(0.4)
        .frame(width: 900, height: 900)
        .position(x: geometry.size.width / 2, y:UIScreen.main.bounds.height + 210)
      VStack(spacing:30){
        Spacer()
        ZStack{
          VStack{
            Color(.white)
              .frame(height:50)
            Spacer().frame(height:0)
            Divider()
          }
          Toggle(isOn: $BoosMood, label: {
            HStack {
              Image("BooSettings")
                .frame(width:35)
              Text("Boo's Mood")
            }
          })
        }
        ZStack{
          VStack{
            Color(.white)
              .frame(height:50)
            Spacer().frame(height:0)
            Divider()
          }
          Toggle(isOn: $Music, label: {
            HStack {
              Image(systemName:"speaker.wave.2.fill")
                .foregroundStyle(Color("Green"))
                .frame(width:35)
              Text("Music")
            }
          })
        }
        ZStack{
          VStack{
            Color(.white)
              .frame(height:50)
            Spacer().frame(height:0)
            Divider()
          }
          Toggle(isOn: $DarkMode, label: {
            HStack {
              Image(systemName:"moon.fill")
                .foregroundStyle(Color("Green"))
                .frame(width:35)
              Text("Dark Mode")
            }
          })
        }
        ZStack{
          VStack{
            Color(.white)
              .frame(height:50)
            Spacer().frame(height:0)
            Divider()
          }
          HStack {
            Image("Exerciseactive")
              .resizable()
              .frame(width:35,height:35)
            Text("Customize Activities")
            Spacer()
            Image(systemName: "chevron.right")
              .foregroundStyle(Color.gray)
          }
        }
        Spacer()
      }
      .padding()
    }
    .font(.system(size: 20))
  }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
