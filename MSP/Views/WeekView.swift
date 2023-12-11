//
//  WeekView.swift
//  MSP
//
//  Created by Marko Lazovic on 05.12.23.
//

import SwiftUI


struct WeekView: View {

    var date: Date
    @State private var currentWeekIndex: Int = 0


    var body: some View {
        NavigationView{
            ZStack{
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 0) {
                        ForEach(2022...2024, id: \.self) { year in
                            WeekColumnView(year: year, baseDate: date, currentWeekIndex: $currentWeekIndex)

                        }
                    }
                }
                .contentMargins(0, for: .scrollContent)
                .scrollTargetBehavior(.viewAligned)
                .padding()
                .padding(.top)
                
                
            }
            .background(Image(GetTheTimeOfDayForBackground())
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                
            )
        }
        .navigationBarHidden(true)
        .onAppear(){
            self.jumpToToday()
        }
        
    }
    
    private func findIndexOfToday() -> Int? {
        let today = Calendar.current.startOfDay(for: Date())
        let baseDay = Calendar.current.startOfDay(for: date)
        let daysDifference = Calendar.current.dateComponents([.day], from: baseDay, to: today).day ?? 0

        // Da jeder Woche 7 Tage hat
        let weekIndex = daysDifference / 7
        return weekIndex
    }
    
    private func jumpToToday() {
            if let todayIndex = findIndexOfToday() {
                currentWeekIndex = todayIndex
            }
        }
}

struct WeekColumnView: View {
    var year: Int
    var baseDate: Date
    @Binding var currentWeekIndex: Int
    var body: some View {
        HStack(spacing: 10) {
            ForEach(0..<weeksInYear(year: year).count, id: \.self) { week in
                VStack(spacing: 10) {
                    ForEach(0..<7) { day in
                        if let dayDate = Calendar.current.date(byAdding: .day, value: day + (week * 7), to: firstDayOfWeek(year: year, baseDate: baseDate)) {
                                DayView(date: dayDate)
                            

                            
                        }
                    }
                }
            }
        }
        .scrollTargetLayout()
    }




}

struct DayView: View {
    var date: Date

    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "de_DE")
        return formatter
    }()

    var body: some View {
        NavigationLink(destination: DayOpenView(datum: dayFullInformation(date))) {
            VStack(alignment: .leading) {
                Text(dayOfWeek(date))
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 80)

                Text(dayOfMonth(date))
                    .font(.system(size: 18))
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 80)
            }
            .frame(width: 355, height: 70)
            .background(Color.black.opacity(0.4))
            .cornerRadius(10)
        }
        
    }
    

    func dayOfWeek(_ date: Date) -> String {
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }

    func dayFullInformation(_ date: Date) -> String {
        dateFormatter.dateFormat = "EEEE d MMMM M yyyy"
        return dateFormatter.string(from: date)
    }
    func dayOfMonth(_ date: Date) -> String {
        dateFormatter.dateFormat = "d. MMMM yyyy"
        return dateFormatter.string(from: date)
    }

    func handleDayTap(date: Date) {
        dateFormatter.dateFormat = "EEEE, d MMMM yyyy"
        let formattedDate = dateFormatter.string(from: date)

        print("Tag geklickt: \(formattedDate)")
        
        
    }
    
    private func findIndexOfToday() -> Int? {
        let today = Calendar.current.startOfDay(for: Date())
        let baseDay = Calendar.current.startOfDay(for: date)
        let daysDifference = Calendar.current.dateComponents([.day], from: baseDay, to: today).day ?? 0

        // Da jeder Woche 7 Tage hat
        let weekIndex = daysDifference / 7
        return weekIndex
    }
}
        


#Preview {
    WeekView(date: Date())
}
