//
//  CalendarView.swift
//  McDonald's
//
//  Created by 윤준성 on 11/30/24.
//

import SwiftUI

struct CalendarView: View {
    @State private var selectedDate = Date() // 사용자가 선택한 날짜
    private let calendar = Calendar.current
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    var body: some View {
        VStack {
            // 현재 달 및 년도 표시
            Text(currentMonthAndYear())
                .font(.headline)
                .padding()
            
            // 요일 헤더
            HStack {
                ForEach(["일", "월", "화", "수", "목", "금", "토"], id: \.self) { day in
                    Text(day)
                        .font(.subheadline)
                        .frame(maxWidth: .infinity)
                }
            }
            
            // 날짜 그리드
            let days = generateDaysInMonth(for: selectedDate)
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
                ForEach(days, id: \.self) { date in
                    Text(date == nil ? "" : "\(calendar.component(.day, from: date!))")
                        .font(.body)
                        .frame(width: 40, height: 40)
                        .background(isSameDay(date, selectedDate) ? Color.blue.opacity(0.8) : Color.clear)
                        .foregroundColor(isWeekend(date) ? .red : .primary)
                        .cornerRadius(20)
                        .onTapGesture {
                            if let validDate = date {
                                selectedDate = validDate
                            }
                        }
                }
            }
            .padding()
            
            // 선택된 날짜 표시
            Text("선택한 날짜: \(dateFormatter.string(from: selectedDate))")
                .padding()
        }
    }
    
    // 현재 월과 년도 반환
    private func currentMonthAndYear() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: selectedDate)
    }
    
    // 주어진 달의 모든 날짜 생성
    private func generateDaysInMonth(for date: Date) -> [Date?] {
        let range = calendar.range(of: .day, in: .month, for: date)!
        let firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: date))!
        let firstWeekday = calendar.component(.weekday, from: firstDayOfMonth) - 1
        let numberOfDays = range.count
        
        var days: [Date?] = Array(repeating: nil, count: firstWeekday) // 첫 주 공백 채우기
        for day in 1...numberOfDays {
            if let date = calendar.date(byAdding: .day, value: day - 1, to: firstDayOfMonth) {
                days.append(date)
            }
        }
        return days
    }
    
    // 주말 여부 확인
    private func isWeekend(_ date: Date?) -> Bool {
        guard let date = date else { return false }
        let weekday = calendar.component(.weekday, from: date)
        return weekday == 1 || weekday == 7 // 일요일(1) 또는 토요일(7)
    }
    
    // 두 날짜가 같은지 확인
    private func isSameDay(_ date1: Date?, _ date2: Date) -> Bool {
        guard let date1 = date1 else { return false }
        return calendar.isDate(date1, inSameDayAs: date2)
    }
}

