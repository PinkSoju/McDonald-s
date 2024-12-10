//
//  ContentView.swift
//  McDonald's
//
//  Created by 윤준성 on 11/30/24.
//

import SwiftUI

struct ContentView: View {
    
  var body: some View {
      VStack {
          Rectangle()
              .fill(Color.yellow)
              .frame(width: 390, height: 100)
              .cornerRadius(30)
      }
      .padding(40)
      VStack {
          CalendarView()
      }
      Spacer()
  }
}
    
#Preview {
    ContentView()
}
