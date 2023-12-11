//
//  WeekViewController.swift
//  MSP
//
//  Created by Marko Lazovic on 09.12.23.
//

import Foundation


func weeksInYear(year: Int) -> ClosedRange<Int> {
    let startDateComponents = DateComponents(year: year, month: 1, day: 1)
    let endDateComponents = DateComponents(year: year + 1, month: 1, day: 1)
    if let startDate = Calendar.current.date(from: startDateComponents),
       let endDate = Calendar.current.date(from: endDateComponents) {
        let weeks = Calendar.current.dateComponents([.weekOfYear], from: startDate, to: endDate).weekOfYear ?? 0
        return 1...weeks
    }
    return 1...52
}
func firstDayOfWeek(year: Int, baseDate: Date) -> Date {
       var components = Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear], from: baseDate)
       components.yearForWeekOfYear = year

       // Setze den ersten Tag der Woche auf Montag
       components.weekday = 2

       guard let firstDay = Calendar.current.date(from: components) else {
           return baseDate
       }

       return firstDay
   }

