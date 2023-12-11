//
//  DayTimeWrapper.swift
//  MSP
//
//  Created by Marko Lazovic on 08.12.23.
//

import Foundation


func GetTheTimeOfDay() -> String{
    var isMorningOrDayOrNight = ""
    let now = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "H"
    let stunde = formatter.string(from: now)
    let StundeInInt = Int(stunde) ?? 0
    
    if StundeInInt > 12 {
        isMorningOrDayOrNight = "Guten Tag, Marko"
        if StundeInInt > 17 {
            isMorningOrDayOrNight = "Guten Abend, Marko"
        }
    }else if StundeInInt < 12 {
        isMorningOrDayOrNight = "Guten Morgen, Marko "
    }
    return isMorningOrDayOrNight
}
func GetTheTimeOfDayForBackground() -> String{
    var isMorningOrDayOrNightBackground = ""
    let now = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "H"
    let stunde = formatter.string(from: now)
    let StundeInInt = Int(stunde) ?? 0
    
    if StundeInInt > 12 {
        isMorningOrDayOrNightBackground = "Hintergrund-Morgen" //Tag
        if StundeInInt > 17 {
            isMorningOrDayOrNightBackground = "Hintergrund-Morgen" //Nacht
        }
    }else if StundeInInt < 12 {
        isMorningOrDayOrNightBackground = "Hintergrund-Morgen"
    }
    return isMorningOrDayOrNightBackground
}


