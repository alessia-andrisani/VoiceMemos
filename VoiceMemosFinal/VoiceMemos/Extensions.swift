//
//  Extensions.swift
//  VoiceMemos
//
//  Created by Alessia Andrisani on 11/12/21.
//

import Foundation
import SwiftUI

//Per il time

extension Date {
    
    var timeFormatted: String {
        let date: Date = Date()
        let newDate =  date.formatted(date: .omitted, time: .shortened)
        
        return newDate
        
    }
}

//Per la duration
extension Double {
    
    var doubleInString: String {
        
        let doubleFormatter = NumberFormatter()
        doubleFormatter.locale = Locale.current
        doubleFormatter.numberStyle = .decimal
        return doubleFormatter.string(from: self as NSNumber) ?? ""
        
    }
 
}





