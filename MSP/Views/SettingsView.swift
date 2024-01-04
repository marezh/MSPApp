//
//  SettingsView.swift
//  MSP
//
//  Created by Marko Lazovic on 03.12.23.
//

import SwiftUI

struct DatabaseView: View {
    @StateObject private var realmManager = RealmManager()

    var body: some View {
        
        Form {
            Text("Datenbank löschen")
            Text("Löschen")
                .foregroundColor(.white)
                .frame(width: 150, height: 23)
                .background(Color.red)
                .cornerRadius(3)
                
                .button {
                print("gelöscht")
                    realmManager.deleteAllData()
            }
        }
            .navigationTitle("Datenbank")
    }
}

// Einstellungsansicht mit NavigationLink
struct SettingsView: View {
    var body: some View {
        ZStack{
            NavigationView {
                Form {
                    Group{
                        NavigationLink(destination: DatabaseView()) {
                            Text("Datenbank")
                        }
                    
                    
                        NavigationLink(destination: DatabaseView()) {
                            Text("Platzhalter")
                        }
                    
                        NavigationLink(destination: DatabaseView()) {
                            Text("Platzhalter")
                        }
                    
                        NavigationLink(destination: DatabaseView()) {
                            Text("Platzhalter ")
                        }
                    }
                    

                    
                    // ... Weitere Einstellungen
                }
                .navigationTitle("Einstellungen")
            }
        }

    }
}

#Preview {
    SettingsView()
}


