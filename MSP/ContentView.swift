//
//  ContentView.swift
//  MSP
//
//  Created by Marko Lazovic on 03.12.23.
//

import SwiftUI


struct ContentView: View {

    var body: some View {
        
            TabView {
                HomeView().tabItem {
                    Image(uiImage: UIImage(named:"home-7")!)
                }
                WeekView(date: Date()).tabItem  {
                    Image(uiImage: UIImage(named:"clock-timer-7")!)
                }
                    
                ExportView().tabItem {
                    Image(uiImage: UIImage(named:"upload-7")!)
                }
                
                SettingsView().tabItem {
                    Image(uiImage: UIImage(named:"gear-7")!)
                }
            }
       
   
    }

            
            
          

        
        
      
    
}

#Preview {
    ContentView()
}
