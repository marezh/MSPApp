//
//  DayOpenView.swift
//  MSP
//
//  Created by Marko Lazovic on 08.12.23.
//

import SwiftUI

struct DayOpenView: View {
    @State private var dragOffset: CGFloat = 0.0
    private let minimumDragTranslationForDismissal: CGFloat = 50.0
    @Environment(\.presentationMode) var presentationMode
    //@ObservedObject var tabBarStatusTest = TabBarStatus.shared
    @State private var visible = true



    var datum: String
    let words: [String]
    var defTagName: String
    var defTagDatum: String
    var defMonatName: String
    var defMonatDatum: String
    var Jahr: String
    
    init(datum: String) {
        self.datum = datum
        self.words = datum.components(separatedBy: " ")
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
            ZStack {
                //Unterste Schicht
                Image(GetTheTimeOfDayForBackground()).resizable().ignoresSafeArea(.all)
                
                //Titel
                VStack(alignment: .leading) {
                    Text(defTagName).foregroundColor(.white).bold().font(.system(size: 28))
                    Text(defTagDatum + "." + defMonatDatum + "." + Jahr).foregroundColor(.gray)
                    Spacer().frame(height: 660)
                }
                .offset(x: -65, y: 0)
                
                VStack {
                    Text("6std.40min").foregroundColor(.white).font(.system(size: 16))
                    Text("      Arbeitszeit").foregroundColor(.gray).font(.system(size: 13))
                    Spacer().frame(height: 660)
                }
                .offset(x: 140, y: 0)
                
                //2 Titel
                VStack {
                    Text("0min").foregroundColor(.white)
                    Text("Gearbeitet").foregroundColor(.gray).font(.system(size: 14))
                }
                .frame(width: 120, height: 55)
                .background(Color.black.opacity(0.3))
                .cornerRadius(30)
                .offset(x: -133, y: -250)
                
                VStack {
                    Text("-8h 40min").foregroundColor(.white)
                    Text("Differenz").foregroundColor(.gray).font(.system(size: 14))
                }
                .frame(width: 120, height: 55)
                .background(Color.black.opacity(0.3))
                .cornerRadius(30)
                .offset(x: 0, y: -250)
                
                VStack {
                    Text("0min").foregroundColor(.white)
                    Text("Pause").foregroundColor(.gray).font(.system(size: 14))
                }
                .frame(width: 120, height: 55)
                .background(Color.black.opacity(0.3))
                .cornerRadius(30)
                .offset(x: 133, y: -250)
                
                
                HStack {
                    Button(" ") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .frame(width: 35, height: 35)
                    .background(Image("icon-go-back"))
                    .cornerRadius(45)
                    
                    NavigationLink(destination: DayEditView()) {
                        Image("icon-add")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .cornerRadius(45)
                        
                    }
                    .padding(10)
                }
                .offset(x: 0, y: 370)
                
                
            }
            .ignoresSafeArea()
            .navigationBarHidden(true)
            .toolbar(visible ? .visible : .hidden , for: .tabBar)            .onAppear(){
                print("geöffnet: DayOpenView")
                visible.toggle()

            }
            .onDisappear(){
                print("geschlossen: DayOpenView")
                visible.toggle()
            }
            
        
            .offset(x: dragOffset)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        withAnimation {
                            let horizontalDragValue =   value.translation.width
                            let verticalDragValue = value.translation.height
                            if abs(horizontalDragValue) > abs(verticalDragValue) {
                                dragOffset = max(horizontalDragValue, 0)
                            }
                            let _ = 1.0 - min(dragOffset / 100, 1.0)
                            if dragOffset > minimumDragTranslationForDismissal {
                                presentationMode.wrappedValue.dismiss()
                            }
                        }
                    }
                
            )
            .transition(.customTrailing)
            
        }
        .navigationBarHidden(true)

        
        
                
                
            
        }

    
        
    }
extension AnyTransition {
    static var customTrailing: AnyTransition {
        let transition = AnyTransition.move(edge: .trailing)
            .combined(with: .opacity)
        return transition
    }
}




#Preview {
    DayOpenView(datum: "")
}
