//
//  setDateFormatter.swift
//  Tabater
//
//  Created by Marek Žiška on 15/05/2020.
//  Copyright © 2020 Marek Žiška. All rights reserved.
//

import Foundation
import SwiftUI

// naformatovanie si datumu cvicenia na moj pozadovany format
extension DateFormatter {
    func getStringCustomFormat(date: Date?) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'  'HH:mm:ss"
        if let unwrappedDate = date {
            return formatter.string(from: unwrappedDate)
        }
        return ""
    }

}

// pouzite pri indexovani core data zaznamov
// rozsiri pole o indexy, vysledkom je tuple s indexom a elementom
extension Collection {
  func enumeratedArray() -> Array<(offset: Int, element: Self.Element)> {
    return Array(self.enumerated())
  }
}

