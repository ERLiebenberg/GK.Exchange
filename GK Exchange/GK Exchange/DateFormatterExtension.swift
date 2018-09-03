//
//  DateFormatterExtension.swift
//  GK Exchange
//
//  Created by Errol Liebenberg on 2018/09/03.
//  Copyright © 2018 Errol Liebenberg. All rights reserved.
//

import Foundation

extension Date {
    
    func dateFormattedDaySuffix() -> String {
        let anchorComponents = Calendar.current.dateComponents([.day, .month, .year], from: self)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        
        var day  = "\(anchorComponents.day!)"
        switch (day) {
        case "1" , "21" , "31":
            day.append("st")
        case "2" , "22":
            day.append("nd")
        case "3" ,"23":
            day.append("rd")
        default:
            day.append("th")
        }
        return day + " " + dateFormatter.string(from: self) + " " + "at" + " " + timeFormatter.string(from: self)
    }
    
}
