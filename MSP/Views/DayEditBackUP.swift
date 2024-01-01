//
//  DayEditView.swift
//  MSP
//
//  Created by Marko Lazovic on 10.12.23.
//

import SwiftUI


struct DayEditBackUP: View {
    var progreeda: String
    let words: [String]
    @State private var setTimeDataPickerFrom = Date.now
    @State private var visible = true
    @State private var isSelectedAnderes = false
    @State private var isSelectedProduktion = false
    @State private var isSelectedMontage = false
    @State private var Firmatatigkeit: String = " "
    @State private var MinutenPickerArbeitszeitBis = 0
    @State private var StundenPickerArbeitszeitBis = 0
    @State private var MinutenPickerArbeitszeitVon = 0
    @State private var StundenPickerArbeitszeitVon = 0
    @State private var selectedStartTime = Date()
    @State private var selectedEndTime = Date()
    @State private var showTimePickerOverlay = false
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
                Image(GetTheTimeOfDayForBackground()).resizable()
                
                HStack{
                    Button(" "){
                    }
                    Button("Abbrechen") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .foregroundColor(.red)
                    
                    Button("Speichern") {
                        print("Arbeitszeit start: \(StundenPickerArbeitszeitVon)  \(MinutenPickerArbeitszeitVon)")

                    }
                    .foregroundColor(.green)
                    .padding(30)
                }
                .frame(width: 393, height: 40)
                .background(Color.black.opacity(0.3))
                .offset(x: 0, y: 380)
                
                
                HStack{
                                        
                    let const = defTagName + "." + defTagDatum + "." + defMonatName + "." + defMonatDatum + "." + Jahr
                
                    if const == getTimeNowForTitle(){
                        
                        Text("Heute")
                            .font(.system(size: 28))
                            .foregroundColor(.white)
                            .frame(width: 100, height: 50)
                            .background(Color.black.opacity(0.3))
                            .cornerRadius(20)
                            .offset(x: -130, y: -330)
                    }else{
                       Text(defTagName
                            + ", \(defTagDatum)"
                            + ".\(defMonatDatum)"
                            + ".\(Jahr)")
                       .font(.system(size: 28))
                       .foregroundColor(.white)
                       .frame(width: 280, height: 50)
                       .background(Color.black.opacity(0.3))
                       .cornerRadius(20)
                       .offset(x: -50, y: -330)
                        
                        
                        
                    }
                    
                }
                
                //TimePicker Zeit
                VStack{
                    
                    Text("Arbeitszeiten").offset(x: -125, y: -200).foregroundColor(.black)
                    

                    HStack {
                        Text("Arbeitsbeginn")
                        Button(action: {
                            showTimePickerOverlay.toggle()
                        }) {
                            Text("\(selectedStartTime)")
                                .padding(10)
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(6)
                        }
                        .overlay(
                            Group {
                                if showTimePickerOverlay {
                                    VStack {
                                        Text("Hier könnte dein Overlay-Inhalt stehen.")
                                        // Füge hier die Inhalte deines Overlays hinzu
                                    }
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .onTapGesture {
                                            withAnimation {
                                                showTimePickerOverlay.toggle()
                                        }
                                    }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .bottom)
                    )
                        .foregroundColor(.black)
                        .offset(x: 10, y: 0)
                            
                            
                    }
                        
                        
                        
                        
                        
                        
                        VStack{
                            //Datum
                        }
                    }
                .frame(width: 370, height: showTimePickerOverlay ? 180 : 90)
                    .background(Color.black.opacity(0.3))
                    .cornerRadius(6)
                    .offset(x: 0, y: -210)
                
                
                
                //Time Picker Pause
                VStack{
                    
                    Text("Pause").offset(y: showTimePickerOverlay ? 100 : 0).offset(x: -150, y: -60).foregroundColor(.black)
                    
                    HStack{
                        VStack{
                            //ZeitPicker Pause
                        }
                        VStack{
                            //Datum
                        }
                    }
                    .frame(width: 370, height: 90)
                    .background(Color.black.opacity(0.3))
                    .cornerRadius(6)
                    .offset(y: showTimePickerOverlay ? 100 : 0)
                    .offset(x: 0, y: -70)
                    
                }

                
                VStack{
                    
                    Text("Firma/Beschreibung").offset(y: showTimePickerOverlay ? 100 : 0).offset(x: -105, y: 60).foregroundColor(.black)
                    
                    HStack{
                        TextField("Eingeben", text: $Firmatatigkeit)
                    }
                    .frame(width: 370, height: 40)
                    .background(Color.black.opacity(0.3))
                    .cornerRadius(6)
                    .offset(y: showTimePickerOverlay ? 100 : 0)
                    .offset(x: 0, y: 50)
                }
                
                //Legende(Montage, produktion, Anderes)
                VStack{
                    
                    Text("Tätigkeit").offset(y: showTimePickerOverlay ? 100 : 0).offset(x: -150, y: 170).foregroundColor(.black)
                    
                    VStack{
                        HStack(spacing: 20){
                            SelectedButtonItem(isSelected: $isSelectedProduktion, color: .blue, text: "Produktion")
                                .frame(width: 100)
                                .onTapGesture {
                                    isSelectedProduktion.toggle()
                                    if(isSelectedProduktion) {
                                        isSelectedMontage = false
                                        isSelectedAnderes = false
                                    }
                                }
                            
                            
                            SelectedButtonItem(isSelected: $isSelectedMontage, color: .blue, text: "Montage")
                                .frame(width: 90)
                                .onTapGesture {
                                    isSelectedMontage.toggle()
                                    if(isSelectedMontage) {
                                        isSelectedProduktion = false
                                        isSelectedAnderes = false
                                    }
                                }
                            
                            
                            SelectedButtonItem(isSelected: $isSelectedAnderes, color: .blue, text: "Anderes")
                                .frame(width: 90)
                                .onTapGesture {
                                    isSelectedAnderes.toggle()
                                    if(isSelectedAnderes) {
                                        isSelectedMontage = false
                                        isSelectedProduktion = false
                                    }
                                }
                        }

                        
                    }
                    .frame(width: 370, height: 45)
                    .background(Color.black.opacity(0.3))
                    .cornerRadius(6)
                    .offset(y: showTimePickerOverlay ? 100 : 0)
                    .offset(x: 0, y: 160)

                }
                
                

                
                
            }
            .navigationBarHidden(true)
            .ignoresSafeArea()
            .toolbar(visible ? .visible : .hidden , for: .tabBar)
            .onAppear(){
                visible.toggle()
            }
            .onDisappear(){
                visible.toggle()
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
        
}

#Preview {
    DayEditBackUP(progreeda: "sdsd")
}
