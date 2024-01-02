//
//  ButtonWrapper.swift
//  MSP
//
//  Created by Marko Lazovic on 02.01.24.
//

import SwiftUI



struct ButtonWrapper: ViewModifier {
    var action: () -> Void
    
    func body(content: Content) -> some View {
        Button {action()} label: {content}
        
    }
}
extension View {
    func button(action: @escaping () -> Void) -> some View {
        modifier(ButtonWrapper(action: action))
    }
}
   


