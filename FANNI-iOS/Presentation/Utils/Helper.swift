//
//  Helper.swift
//  FANNI-iOS
//
//  Created by JongHoon on 2023/02/23.
//

import Foundation


/// Date -> yyyy / MM / dd
/// - Parameter date: 변경할 date
/// - Returns: 변경된 String
func dateToString(date: Date) -> String {
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy / MM / dd"
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.timeZone = TimeZone(identifier: "KST")
        
        return dateFormatter
    }()
    
    return dateFormatter.string(from: date)
}
