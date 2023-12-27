//
//  SelectedButtonItem.swift
//  MSP
//
//  Created by Marko Lazovic on 17.12.23.
//

import SwiftUI

struct SelectedButtonItem: View {
    
    @Binding var isSelected: Bool
    @State var color: Color
    @State var text: String
    
    var body: some View {
        ZStack{
            Capsule()
                .frame(height: 30)
                .foregroundColor(isSelected ? color: .gray)
            Text(text).foregroundColor(.white)
        }
    }
    
    
}



struct SelectedButtonPreviews: PreviewProvider {
    
    static var previews: some View{
                
        SelectedButtonItem(isSelected: .constant(false), color: Color.blue, text: "Option")
        
        
        }
}

