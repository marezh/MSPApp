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
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var realmManager = RealmManager()

    @State private var selectedStartTime = Date()
    @State private var selectedEndTime = Date()
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
   
    
    
    func SaveData() {
        var TätigkeitButonString: String
        let gesamtArbeitsStunden = StundenPickerArbeitszeitBis - StundenPickerArbeitszeitVon
        let gesamtArbeitsMinuten = MinutenPickerArbeitszeitBis - MinutenPickerArbeitszeitVon
        let gesamteArbeitszeitMinuten = gesamtArbeitsStunden * 60 + gesamtArbeitsMinuten
        
        // Berechnung der Gesamtpausenzeit in Minuten
        let gesamtPauseStunden = PauseStundenPickerArbeitszeitBis - PauseStundenPickerArbeitszeitVon
        let gesamtPauseMinuten = PauseMinutenPickerArbeitszeitBis - PauseMinutenPickerArbeitszeitVon
        let gesamtePausenzeitMinuten = gesamtPauseStunden * 60 + gesamtPauseMinuten
        
        // Berechnung der Arbeitszeit nach Abzug der Pausenzeit
        let nettoArbeitszeitMinuten = gesamteArbeitszeitMinuten - gesamtePausenzeitMinuten
        let nettoArbeitszeitStunden = nettoArbeitszeitMinuten / 60
        let restNettoArbeitszeitMinuten = nettoArbeitszeitMinuten % 60
        
        print("Gesamtarbeitszeit: \(gesamteArbeitszeitMinuten / 60) Stunden und \(gesamteArbeitszeitMinuten % 60) Minuten")
        print("Gesamtpausenzeit: \(gesamtePausenzeitMinuten / 60) Stunden und \(gesamtePausenzeitMinuten % 60) Minuten")
        print("Nettoarbeitszeit: \(nettoArbeitszeitStunden) Stunden und \(restNettoArbeitszeitMinuten) Minuten")
        
        if isSelectedMontage {
            print("Montage ausgewählt")
            TätigkeitButonString = "Montage"
        }else if isSelectedProduktion {
            print("Produktion ausgewählt")
            TätigkeitButonString = "Produktion"
        }else if isSelectedAnderes {
            print("Anderes ausgewählt")
            TätigkeitButonString = "Anderes"
        }else {
            print("Keine Auswahl")
            TätigkeitButonString = "Keine Auswahl"
        }
        realmManager.addDay(dayId: progreeda, totalHours: nettoArbeitszeitStunden, totalMinutes: restNettoArbeitszeitMinuten)
        
        
        print("\(realmManager.getTotalHours(for: progreeda))")
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                Image(GetTheTimeOfDayForBackground())
                TitleFrame(
                    defTagName: defTagName,
                    defTagDatum: defTagDatum,
                    defMonatName: defMonatName,
                    defMonatDatum: defMonatDatum,
                    jahr: Jahr).offset(x: 0, y: -330)
                HStack(spacing: 34){
                    Text("Abbrechen")
                        .foregroundColor(.red)
                        .button {
                            print("schliessen")
                            presentationMode.wrappedValue.dismiss()
                        }
                    Text("Speichern")
                        .foregroundColor(.green)
                        .button {
                            SaveData()
                            presentationMode.wrappedValue.dismiss()
                        }
                }
                .offset(x: 0, y: 350)
                .frame(width: 360, height: 100)
                ScrollView(showsIndicators: false){
                    VStack(spacing: 30){
                        WorkTimeFrame(timePickerLayout0: $showTimePickerOverlay0,
                                      timePickerLayout1: $showTimePickerOverlay1,
                                      PausetimePickerLayout0: $PauseShowTimePickerOverlay0, PausetimePickerLayout1: $PauseShowTimePickerOverlay1,
                                      timePickerLayoutOption: $showTimePickerOverlayOption,timePickerLayoutOptionPause: $PauseshowTimePickerOverlayOption,
                                      hoursvon: $StundenPickerArbeitszeitVon,
                                      minutesvon: $MinutenPickerArbeitszeitVon,
                                      hoursbis: $StundenPickerArbeitszeitBis,
                                      minutesbis: $MinutenPickerArbeitszeitBis)
                        BreakeTimeFrame(timePickerLayout0: $PauseShowTimePickerOverlay0,
                                        timePickerLayout1: $PauseShowTimePickerOverlay1, WorktimePickerLayout0: $showTimePickerOverlay0, WorktimePickerLayout1: $showTimePickerOverlay1,
                                        timePickerLayoutOption: $PauseshowTimePickerOverlayOption,timePickerLayoutOptionWorkFrame: $showTimePickerOverlayOption,
                                        hoursvon: $PauseStundenPickerArbeitszeitVon,
                                        minutesvon: $PauseMinutenPickerArbeitszeitVon,
                                        hoursbis: $PauseStundenPickerArbeitszeitBis,
                                        minutesbis: $PauseMinutenPickerArbeitszeitBis)
                        KommentarFrame(tatigkeit: Firmatatigkeit)
                        TaskFrame(isSelectedProduktion: isSelectedProduktion, isSelectedMontage: isSelectedMontage, isSelectedAnderes: isSelectedAnderes)
                    }
                    
                    
                    
                }
                .frame(width: 100, height: 460)
                .offset(x: 0, y: -30)
                
                
            }
            .ignoresSafeArea()
            
            
            
        }
        .navigationBarHidden(true)
        .toolbar(visible ? .visible : .hidden , for: .tabBar)
        .onAppear(){
            visible.toggle()
        }
        .onDisappear(){
            visible.toggle()
        }
        
        
        
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
                    .font(.system(size: 25))
                    .bold()
            }
            .cornerRadius(45.0)
        }
    }
    
    struct WorkTimeFrame: View{
        @Binding var timePickerLayout0: Bool
        @Binding var timePickerLayout1: Bool
        @Binding var PausetimePickerLayout0: Bool
        @Binding var PausetimePickerLayout1: Bool
        @Binding var timePickerLayoutOption: Bool
        @Binding var timePickerLayoutOptionPause: Bool

        
        @Binding var hoursvon: Int
        @Binding var minutesvon: Int
        @Binding var hoursbis: Int
        @Binding var minutesbis: Int
        //private var currentDate = Date()
        
        
        var body: some View {
            VStack(alignment: .leading, spacing: 1) {
                Text("Arbeitszeit").foregroundColor(.white)
                
                ZStack {
                    HStack(spacing: 23) {
                        //Arbeit von
                        Button(action: {
                            withAnimation {
                                timePickerLayoutOptionPause = false
                                PausetimePickerLayout0 = false
                                PausetimePickerLayout1 = false
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
                            
                            Text("\(String(format: "%02d", hoursvon)):\(String(format: "%02d", minutesvon)) Uhr")
                                    .frame(width: 130, height: 13)
                                    .padding(10)
                                    .background(timePickerLayout0 ? Color.green.opacity(0.3) : Color.gray.opacity(0.3))
                                    .cornerRadius(6)
                                    .offset(y: timePickerLayoutOption ? -80 : 0)
                           
                        }
                        .foregroundColor(.black)
                        
                        //Arbeit bis
                        Button(action: {
                            withAnimation {
                                timePickerLayoutOptionPause = false
                                PausetimePickerLayout0 = false
                                PausetimePickerLayout1 = false
                                if timePickerLayout0 || timePickerLayout1 {
                                    // Schließe das Overlay und setze timePickerLayoutOption auf false
                                    timePickerLayout0 = false
                                    timePickerLayout1 = false
                                    timePickerLayoutOption = false
                                } else {
                                    // Öffne das Overlay
                                    timePickerLayout0 = false
                                    timePickerLayout1 = true
                                    PausetimePickerLayout0 = false
                                    PausetimePickerLayout1 = false
                                    timePickerLayoutOption = true
                                }
                            }
                        }) {
                            
                            Text("\(String(format: "%02d", hoursbis)):\(String(format: "%02d", minutesbis)) Uhr")

                                    .frame(width: 130, height: 13)
                                    .padding(10)
                                    .background(timePickerLayout1 ? Color.green.opacity(0.3) : Color.gray.opacity(0.3))
                                    .cornerRadius(6)
                                    .offset(y: timePickerLayoutOption ? -80 : 0)
                            
                            
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
    @Binding var timePickerLayout0: Bool
    @Binding var timePickerLayout1: Bool
    @Binding var WorktimePickerLayout0: Bool
    @Binding var WorktimePickerLayout1: Bool
    @Binding var timePickerLayoutOption: Bool
    @Binding var timePickerLayoutOptionWorkFrame: Bool
    @Binding var hoursvon: Int
    @Binding var minutesvon: Int
    @Binding var hoursbis: Int
    @Binding var minutesbis: Int
    @State private var currentDate = Date()
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            Text("Pause").foregroundColor(.white)
            
            ZStack {
                HStack(spacing: 23) {
                    //Arbeit von
                    Button(action: {
                        withAnimation {
                            timePickerLayoutOptionWorkFrame = false
                            WorktimePickerLayout0 = false
                            WorktimePickerLayout1 = false

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
                        
                        Text("\(String(format: "%02d", hoursvon)):\(String(format: "%02d", minutesvon)) Uhr")
                                .frame(width: 130, height: 13)
                                .padding(10)
                                .background(timePickerLayout0 ? Color.green.opacity(0.3) : Color.gray.opacity(0.3))
                                .cornerRadius(6)
                                .offset(y: timePickerLayoutOption ? -80 : 0)
                      
                        
                        
                        
                        
                        
                        
                        
                        
                    }
                    .foregroundColor(.black)
                    
                    //Arbeit bis
                    Button(action: {
                        withAnimation {
                            timePickerLayoutOptionWorkFrame = false
                            WorktimePickerLayout0 = false
                            WorktimePickerLayout1 = false
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
                        
                        Text("\(String(format: "%02d", hoursbis)):\(String(format: "%02d", minutesbis)) Uhr")
                                .frame(width: 130, height: 13)
                                .padding(10)
                                .background(timePickerLayout1 ? Color.green.opacity(0.3) : Color.gray.opacity(0.3))
                                .cornerRadius(6)
                                .offset(y: timePickerLayoutOption ? -80 : 0)
                        
                        
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
    @State var isSelectedProduktion: Bool
    @State var isSelectedMontage: Bool
    @State var isSelectedAnderes: Bool
    
    var body: some View{
        VStack(alignment: .leading, spacing: 1){
            Text("Tätigkeit").foregroundColor(.white)
            
            ZStack{
                HStack(spacing: 20){
                    SelectedButtonItem(isSelected: $isSelectedProduktion, color: .blue, text: "Produktion")
                        .frame(width: 100)
                        .onTapGesture {
                            withAnimation {
                                isSelectedProduktion.toggle()
                                if(isSelectedProduktion) {
                                    isSelectedMontage = false
                                    isSelectedAnderes = false
                                }
                            }
                            
                        }
                    
                    
                    SelectedButtonItem(isSelected: $isSelectedMontage, color: .blue, text: "Montage")
                        .frame(width: 90)
                        .onTapGesture {
                            withAnimation {
                                isSelectedMontage.toggle()
                                if(isSelectedMontage) {
                                    isSelectedProduktion = false
                                    isSelectedAnderes = false
                                }
                            }
                            
                        }
                    
                    
                    SelectedButtonItem(isSelected: $isSelectedAnderes, color: .blue, text: "Anderes")
                        .frame(width: 90)
                        .onTapGesture {
                            withAnimation {
                                isSelectedAnderes.toggle()
                                if(isSelectedAnderes) {
                                    isSelectedMontage = false
                                    isSelectedProduktion = false
                                }
                            }
                            
                        }
                }
            }
            .frame(width: 360, height: 50)
            .background(Color.black.opacity(0.1))
        }
    }
}
struct KommentarFrame: View{
    @State var tatigkeit: String
    
    var body: some View{
        
        VStack(alignment: .leading, spacing: 1){
            Text("Firma/Tätigkeit").foregroundColor(.white)
            
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
