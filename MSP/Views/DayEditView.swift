//
//  DayEditView.swift
//  MSP
//
//  Created by Marko Lazovic on 10.12.23.
//

import SwiftUI




struct DayEditView: View {
    var progreeda: String
    let words: [String]
    @State private var visible = true
    @State private var isSelectedAnderes = false
    @State private var isSelectedProduktion = false
    @State private var isSelectedMontage = false
    @State private var Firmatatigkeit: String = " "
    @State private var MinutenPickerArbeitszeitBis = 0
    @State private var StundenPickerArbeitszeitBis = 0
    @State private var MinutenPickerArbeitszeitVon = 0
    @State private var StundenPickerArbeitszeitVon = 0
    @State private var PauseMinutenPickerArbeitszeitBis = 0
    @State private var PauseStundenPickerArbeitszeitBis = 0
    @State private var PauseMinutenPickerArbeitszeitVon = 0
    @State private var PauseStundenPickerArbeitszeitVon = 0
    @State private var showTimePickerOverlay0 = false
    @State private var showTimePickerOverlay1 = false
    @State private var PauseShowTimePickerOverlay0 = false
    @State private var PauseShowTimePickerOverlay1 = false
    @State private var showTimePickerOverlayOption = false
    @State private var PauseshowTimePickerOverlayOption = false

    @State private var selectedStartTime = Date()
    @State private var selectedEndTime = Date()
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedTätigkeit = 1

    var defTagName: String
    var defTagDatum: String
    var defMonatName: String
    var defMonatDatum: String
    var Jahr: String
    init(progreeda: String) {
        self.progreeda = progreeda
        self.words = progreeda.components(separatedBy: " ")
        if words.count >= 5 {
            self.defTagName = words[0]
            self.defTagDatum = words[1]
            self.defMonatName = words[2]
            self.defMonatDatum = words[3]
            self.Jahr = words[4]
        } else {
            // Handle the case where there are not enough elements in the 'words' array
            self.defTagName = "Montag"
            self.defTagDatum = "09"
            self.defMonatName = "Dezember"
            self.defMonatDatum = "12"
            self.Jahr = "2023"
        }
    }
    
    
    var body: some View {
        
        NavigationStack{
            ZStack{
                Image(GetTheTimeOfDayForBackground())
                
                VStack (spacing: 20){
                
                TitleFrame(
                    defTagName: defTagName,
                    defTagDatum: defTagDatum,
                    defMonatName: defMonatName,
                    defMonatDatum: defMonatDatum,
                    jahr: Jahr).offset(x: -70, y: -10)
                
                WorkTimeFrame(timePickerLayout0: showTimePickerOverlay0,
                              timePickerLayout1: showTimePickerOverlay1,
                              timePickerLayoutOption: showTimePickerOverlayOption,
                              hoursvon: StundenPickerArbeitszeitBis,
                              minutesvon: MinutenPickerArbeitszeitBis,
                              hoursbis: StundenPickerArbeitszeitVon,
                              minutesbis: MinutenPickerArbeitszeitVon)
                BreakeTimeFrame(timePickerLayout0: PauseShowTimePickerOverlay0,
                                timePickerLayout1: PauseShowTimePickerOverlay1,
                                timePickerLayoutOption: PauseshowTimePickerOverlayOption,
                                hoursvon: PauseStundenPickerArbeitszeitBis,
                                minutesvon: PauseMinutenPickerArbeitszeitBis,
                                hoursbis: PauseStundenPickerArbeitszeitVon,
                                minutesbis: PauseMinutenPickerArbeitszeitVon)
                KommentarFrame(tatigkeit: Firmatatigkeit)
                TaskFrame()
                ButtonFrame().offset(x: 0, y: 40)
                    
                    
                }
            }
            .ignoresSafeArea()
            
         
        }
        .navigationBarHidden(true)

           
    }
    
    struct TitleFrame: View{
        var defTagName: String
        var defTagDatum: String
        var defMonatName: String
        var defMonatDatum: String
        var jahr: String
        var body: some View{
            let const = defTagName + ", " + defTagDatum + "." + defMonatDatum + "." + jahr
                ZStack(){
                    Text(const)
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .offset(x: 0, y: 0)
                }
                .frame(width: 250, height: 50)
                .background(Color.black.opacity(0.1))
                .cornerRadius(45.0)
        }
    }
    
    struct WorkTimeFrame: View{
        @State var timePickerLayout0: Bool
        @State var timePickerLayout1: Bool
        @State var timePickerLayoutOption: Bool

        @State var hoursvon: Int
        @State var minutesvon: Int
        @State var hoursbis: Int
        @State var minutesbis: Int
        @State private var currentDate = Date()


        var body: some View {
            VStack(alignment: .leading, spacing: 1) {
                Text("Arbeitszeit").foregroundColor(.white)

                ZStack {
                    HStack(spacing: 0) {
                        //Arbeit von
                        Button(action: {
                            withAnimation {
                                if timePickerLayout0 || timePickerLayout1 {
                                // Schließe das Overlay und setze timePickerLayoutOption auf false
                                timePickerLayout0 = false
                                timePickerLayout1 = false
                                timePickerLayoutOption = false
                                } else {
                                                    // Öffne das Overlay
                                timePickerLayout0 = true
                                timePickerLayout1 = false
                                timePickerLayoutOption = true
                            }

                            }

                        }) {
                            
                            if(hoursvon == 0 && minutesvon == 0){
                                Text("\(getCurrentTime(Date())):00 Uhr")
                                     .frame(width: 130, height: 13)
                                     .padding(10)
                                     .background(timePickerLayout0 ? Color.green.opacity(0.3) : Color.gray.opacity(0.3))
                                     .cornerRadius(6)
                                     .offset(x: -20, y: timePickerLayoutOption ? -80 : 0)
                            }else{
                                Text("\(hoursvon):\(minutesvon):00 Uhr")
                                     .frame(width: 130, height: 13)
                                     .padding(10)
                                     .background(timePickerLayout0 ? Color.green.opacity(0.3) : Color.gray.opacity(0.3))
                                     .cornerRadius(6)
                                     .offset(x: -20, y: timePickerLayoutOption ? -80 : 0)
                            }
                            

                            


                                
                            
 
                        }
                        .foregroundColor(.black)

                        //Arbeit bis
                        Button(action: {
                            withAnimation {

                                if timePickerLayout0 || timePickerLayout1 {
                                    // Schließe das Overlay und setze timePickerLayoutOption auf false
                                    timePickerLayout0 = false
                                    timePickerLayout1 = false
                                    timePickerLayoutOption = false
                                } else {
                                    // Öffne das Overlay
                                    timePickerLayout0 = false
                                    timePickerLayout1 = true
                                    timePickerLayoutOption = true
                                }
                            }
                        }) {
                            
                            if(hoursbis == 0 && minutesbis == 0) {
                                Text("\(getCurrentTimewithOneHour(Date())):\(getCurrentTimeOnlyMinutes(Date())):00 Uhr")
                                    .frame(width: 130, height: 13)
                                    .padding(10)
                                    .background(timePickerLayout1 ? Color.green.opacity(0.3) : Color.gray.opacity(0.3))
                                    .cornerRadius(6)
                                    .offset(x: 10, y: timePickerLayoutOption ? -80 : 0)
                            }else{
                                Text("\(hoursbis):\(minutesbis):00 Uhr")
                                     .frame(width: 130, height: 13)
                                     .padding(10)
                                     .background(timePickerLayout0 ? Color.green.opacity(0.3) : Color.gray.opacity(0.3))
                                     .cornerRadius(6)
                                     .offset(x: -20, y: timePickerLayoutOption ? -80 : 0)
                            }

                        }
                        .foregroundColor(.black)
                    }

                    if timePickerLayout0 {
                        VStack {
                            GeometryReader { geometry in
                                HStack (spacing: 0){
                                    Picker("Stunden", selection: $hoursvon) {
                                        ForEach(0..<24, id: \.self) { hour in
                                            Text("\(hour)").foregroundColor(.white)
                                                .tag(hour)
                                        }
                                    }
                                    .frame(width: geometry.size.width / 2, height: 150)
                                    .clipped()
                                    .pickerStyle(WheelPickerStyle())

                                    Picker("Minuten", selection: $minutesvon) {
                                        ForEach(0..<60, id: \.self) { minute in
                                            Text("\(minute)").foregroundColor(.white)
                                                .tag(minute)
                                        }
                                    }
                                    .frame(width: geometry.size.width / 2, height: 150)
                                    .clipped()
                                    .pickerStyle(WheelPickerStyle())

                                }
                            }
                            .padding()
                            .cornerRadius(10)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                        .offset(y: 60)
                    }
                    
                    if timePickerLayout1 {
                        VStack {
                            GeometryReader { geometry in
                                HStack (spacing: 0){
                                    Picker("Stunden", selection: $hoursbis) {
                                        ForEach(0..<24, id: \.self) { hour in
                                            Text("\(hour)").foregroundColor(.white)
                                                .tag(hour)
                                        }
                                    }
                                    .frame(width: geometry.size.width / 2, height: 150)
                                    .clipped()
                                    .pickerStyle(WheelPickerStyle())

                                    Picker("Minuten", selection: $minutesbis) {
                                        ForEach(0..<60, id: \.self) { minute in
                                            Text("\(minute)").foregroundColor(.white)
                                                .tag(minute)
                                        }
                                    }
                                    .frame(width: geometry.size.width / 2, height: 150)
                                    .clipped()
                                    .pickerStyle(WheelPickerStyle())

                                }
                            }
                            .padding()
                            .cornerRadius(10)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                        .offset(y: 60)
                    }
                    
                }
                .frame(width: 360, height: timePickerLayoutOption ? 240 : 60)
                .background(Color.black.opacity(0.1))
                .scaleEffect(x: 1.0, y: timePickerLayoutOption ? 0.9 : 1.0) // Skalierung anpassen
                .onTapGesture {
                    withAnimation {
                        timePickerLayout0 = false
                        timePickerLayout1 = false
                        timePickerLayoutOption = false
                    }
                }
            }
        }
        func getCurrentTime(_ date: Date) -> String {
            
            
            let dateFormatter: DateFormatter = {
                let formatter = DateFormatter()
                formatter.locale = Locale(identifier: "de_DE")
                return formatter
            }()
            
            dateFormatter.dateFormat = "HH:mm"
            return dateFormatter.string(from: date)
        }
        
        func getCurrentTimeOnlyMinutes(_ date: Date) -> String {
            
            
            let dateFormatter: DateFormatter = {
                let formatter = DateFormatter()
                formatter.locale = Locale(identifier: "de_DE")
                return formatter
            }()
            
            dateFormatter.dateFormat = "mm"
            return dateFormatter.string(from: date)
        }

        
        
        func getCurrentTimewithOneHour(_ date: Date) -> Int {
            var int = 0
            
            let dateFormatter: DateFormatter = {
                let formatter = DateFormatter()
                formatter.locale = Locale(identifier: "de_DE")
                return formatter
            }()
            
            dateFormatter.dateFormat = "HH"
            
            int = Int(dateFormatter.string(from: date)) ?? 0
            
            return int+1
        }
    }

}
    
    struct BreakeTimeFrame: View{
        @State var timePickerLayout0: Bool
        @State var timePickerLayout1: Bool
        @State var timePickerLayoutOption: Bool

        @State var hoursvon: Int
        @State var minutesvon: Int
        @State var hoursbis: Int
        @State var minutesbis: Int
        @State private var currentDate = Date()


        var body: some View {
            VStack(alignment: .leading, spacing: 1) {
                Text("Pause").foregroundColor(.white)

                ZStack {
                    HStack(spacing: 0) {
                        //Arbeit von
                        Button(action: {
                            withAnimation {
                                if timePickerLayout0 || timePickerLayout1 {
                                // Schließe das Overlay und setze timePickerLayoutOption auf false
                                timePickerLayout0 = false
                                timePickerLayout1 = false
                                timePickerLayoutOption = false
                                } else {
                                                    // Öffne das Overlay
                                timePickerLayout0 = true
                                timePickerLayout1 = false
                                timePickerLayoutOption = true
                            }

                            }

                        }) {
                            
                            if(hoursvon == 0 && minutesvon == 0){
                                Text("\(getCurrentTime(Date())):00 Uhr")
                                     .frame(width: 130, height: 13)
                                     .padding(10)
                                     .background(timePickerLayout0 ? Color.green.opacity(0.3) : Color.gray.opacity(0.3))
                                     .cornerRadius(6)
                                     .offset(x: -20, y: timePickerLayoutOption ? -80 : 0)
                            }else{
                                Text("\(hoursvon):\(minutesvon):00 Uhr")
                                     .frame(width: 130, height: 13)
                                     .padding(10)
                                     .background(timePickerLayout0 ? Color.green.opacity(0.3) : Color.gray.opacity(0.3))
                                     .cornerRadius(6)
                                     .offset(x: -20, y: timePickerLayoutOption ? -80 : 0)
                            }
                            

                            


                                
                            
 
                        }
                        .foregroundColor(.black)

                        //Arbeit bis
                        Button(action: {
                            withAnimation {

                                if timePickerLayout0 || timePickerLayout1 {
                                    // Schließe das Overlay und setze timePickerLayoutOption auf false
                                    timePickerLayout0 = false
                                    timePickerLayout1 = false
                                    timePickerLayoutOption = false
                                } else {
                                    // Öffne das Overlay
                                    timePickerLayout0 = false
                                    timePickerLayout1 = true
                                    timePickerLayoutOption = true
                                }
                            }
                        }) {
                            
                            if(hoursbis == 0 && minutesbis == 0) {
                                Text("\(getCurrentTimewithOneHour(Date())):\(getCurrentTimeOnlyMinutes(Date())):00")
                                    .frame(width: 130, height: 13)
                                    .padding(10)
                                    .background(timePickerLayout1 ? Color.green.opacity(0.3) : Color.gray.opacity(0.3))
                                    .cornerRadius(6)
                                    .offset(x: 10, y: timePickerLayoutOption ? -80 : 0)
                            }else{
                                Text("\(hoursbis):\(minutesbis):00")
                                     .frame(width: 130, height: 13)
                                     .padding(10)
                                     .background(timePickerLayout0 ? Color.green.opacity(0.3) : Color.gray.opacity(0.3))
                                     .cornerRadius(6)
                                     .offset(x: -20, y: timePickerLayoutOption ? -80 : 0)
                            }

                        }
                        .foregroundColor(.black)
                    }

                    if timePickerLayout0 {
                        VStack {
                            GeometryReader { geometry in
                                HStack (spacing: 0){
                                    Picker("Stunden", selection: $hoursvon) {
                                        ForEach(0..<24, id: \.self) { hour in
                                            Text("\(hour)").foregroundColor(.white)
                                                .tag(hour)
                                        }
                                    }
                                    .frame(width: geometry.size.width / 2, height: 150)
                                    .clipped()
                                    .pickerStyle(WheelPickerStyle())

                                    Picker("Minuten", selection: $minutesvon) {
                                        ForEach(0..<60, id: \.self) { minute in
                                            Text("\(minute)").foregroundColor(.white)
                                                .tag(minute)
                                        }
                                    }
                                    .frame(width: geometry.size.width / 2, height: 150)
                                    .clipped()
                                    .pickerStyle(WheelPickerStyle())

                                }
                            }
                            .padding()
                            .cornerRadius(10)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                        .offset(y: 60)
                    }
                    
                    if timePickerLayout1 {
                        VStack {
                            GeometryReader { geometry in
                                HStack (spacing: 0){
                                    Picker("Stunden", selection: $hoursbis) {
                                        ForEach(0..<24, id: \.self) { hour in
                                            Text("\(hour)").foregroundColor(.white)
                                                .tag(hour)
                                        }
                                    }
                                    .frame(width: geometry.size.width / 2, height: 150)
                                    .clipped()
                                    .pickerStyle(WheelPickerStyle())

                                    Picker("Minuten", selection: $minutesbis) {
                                        ForEach(0..<60, id: \.self) { minute in
                                            Text("\(minute)").foregroundColor(.white)
                                                .tag(minute)
                                        }
                                    }
                                    .frame(width: geometry.size.width / 2, height: 150)
                                    .clipped()
                                    .pickerStyle(WheelPickerStyle())

                                }
                            }
                            .padding()
                            .cornerRadius(10)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                        .offset(y: 60)
                    }
                    
                }
                .frame(width: 360, height: timePickerLayoutOption ? 240 : 60)
                .background(Color.black.opacity(0.1))
                .scaleEffect(x: 1.0, y: timePickerLayoutOption ? 0.9 : 1.0) // Skalierung anpassen
                .onTapGesture {
                    withAnimation {
                        timePickerLayout0 = false
                        timePickerLayout1 = false
                        timePickerLayoutOption = false
                    }
                }
            }
        }
        func getCurrentTime(_ date: Date) -> String {
            
            
            let dateFormatter: DateFormatter = {
                let formatter = DateFormatter()
                formatter.locale = Locale(identifier: "de_DE")
                return formatter
            }()
            
            dateFormatter.dateFormat = "HH:mm"
            return dateFormatter.string(from: date)
        }
        
        func getCurrentTimeOnlyMinutes(_ date: Date) -> String {
            
            
            let dateFormatter: DateFormatter = {
                let formatter = DateFormatter()
                formatter.locale = Locale(identifier: "de_DE")
                return formatter
            }()
            
            dateFormatter.dateFormat = "mm"
            return dateFormatter.string(from: date)
        }

        
        
        func getCurrentTimewithOneHour(_ date: Date) -> Int {
            var int = 0
            
            let dateFormatter: DateFormatter = {
                let formatter = DateFormatter()
                formatter.locale = Locale(identifier: "de_DE")
                return formatter
            }()
            
            dateFormatter.dateFormat = "HH"
            
            int = Int(dateFormatter.string(from: date)) ?? 0
            
            return int+1
        }
    }




    
    
    struct TaskFrame: View{
        var body: some View{
            VStack(alignment: .leading, spacing: 1){
                Text("Tätigkeit").foregroundColor(.white)
                
                ZStack{
                    
                }
                .frame(width: 360, height: 100)
                .background(Color.black.opacity(0.1))
            }
        }
    }
    
    struct ButtonFrame: View{
        var body: some View{
            VStack(alignment: .leading, spacing: 0){
                Text("Buttons").foregroundColor(.white)
                
                ZStack{
                    
                }
                .frame(width: 360, height: 100)
                .background(Color.black.opacity(0.1))
            }
        }
    }
    struct KommentarFrame: View{
        @State var tatigkeit: String

        var body: some View{
            
            VStack(alignment: .leading, spacing: 1){
                Text("Kommentar").foregroundColor(.white)
                
                ZStack{
                    HStack{
                        TextField("Eingeben", text: $tatigkeit).foregroundColor(.white)

                    }.frame(width: 360, height: 50)
                    
                }
                .frame(width: 360, height: 50)
                .background(Color.black.opacity(0.1))
            }
        }
    }
    

func getTimeNowForTitle() -> String {
   var st = ""
   let now = Date()
   let formatter = DateFormatter()
   formatter.dateFormat = "EEEE.d.MMMM.M.yyyy"
   formatter.locale = Locale(identifier: "de_DE")
   st = formatter.string(from: now)
   return st
}
func getYesterdayDateString() -> String {
   let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
   let formatter = DateFormatter()
   formatter.dateFormat = "EEEE.d.MMMM.M.yyyy"
   formatter.locale = Locale(identifier: "de_DE")
   return formatter.string(from: yesterday)
}

#Preview {
    DayEditView(progreeda: "sdsd")
}
