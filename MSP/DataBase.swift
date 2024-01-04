//
//  DataBase.swift
//  MSP
//
//  Created by Marko Lazovic on 02.01.24.
//

import Foundation
import SwiftUI
import RealmSwift





class DayConstructor: Object {
    @Persisted var DayId: String = ""
    @Persisted var Totalhours: Int = 0
    @Persisted var TotalMinutes: Int = 0
    
    convenience init(DayId: String, Totalhours: Int, TotalMinutes: Int) {
        self.init()
        self.DayId = DayId
        self.Totalhours = Totalhours
        self.TotalMinutes = TotalMinutes
    }
}

class RealmManager: ObservableObject {
    private var localRealm: Realm?
    
    init() {
        openRealm()
    }
    
    func openRealm() {
        do {
            let config = Realm.Configuration(schemaVersion: 2)
            Realm.Configuration.defaultConfiguration = config
            localRealm = try Realm()
        } catch {
            print("Error opening Realm", error)
        }
    }
    
    func addDay(dayId: String, totalHours: Int, totalMinutes: Int) {
        if let localRealm = localRealm {
            do {
                let day = DayConstructor(DayId: dayId, Totalhours: totalHours, TotalMinutes: totalMinutes)
                try localRealm.write {
                    localRealm.add(day)
                    print("Added new Day to Realm!")
                    print("Gespeicherte Daten: \(dayId)")
                }
            } catch {
                print("Error adding Day to Realm", error)
            }
        }
    }
    func getTotalHours(for dayId: String) -> Int {
            guard let localRealm = localRealm else {
                print("Realm is not initialized")
                return 0
            }
            let results = localRealm.objects(DayConstructor.self).filter("DayId == %@", dayId)
            // Wenn keine Objekte mit der angegebenen DayId gefunden werden, gibt sum(ofProperty:) 0 zurück
            return results.sum(ofProperty: "Totalhours")
        }
    
    func getTotalMinutes(for dayId: String) -> Int {
            guard let localRealm = localRealm else {
                print("Realm is not initialized")
                return 0
            }
            let results = localRealm.objects(DayConstructor.self).filter("DayId == %@", dayId)
            // Wenn keine Objekte mit der angegebenen DayId gefunden werden, gibt sum(ofProperty:) 0 zurück
            return results.sum(ofProperty: "TotalMinutes")
        }
    func deleteAllData() {
        if let localRealm = localRealm {
            do {
                try localRealm.write {
                    localRealm.deleteAll()
                    print("Alle Daten erfolgreich gelöscht.")
                }
            } catch {
                print("Fehler beim Löschen aller Daten: \(error)")
            }
        }
    }

    
    // Weitere Methoden zur Datenabfrage oder -manipulation...
}

