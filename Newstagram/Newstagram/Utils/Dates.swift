//
//  Dates.swift
//  Newstagram
//
//  Created by Grzegorz Surma on 30/03/2018.
//  Copyright © 2018 Grzegorz Surma. All rights reserved.
//

import Foundation

func convertDateFormatter(date: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    if let convertedDate = dateFormatter.date(from: date) as Date? {
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let timeStamp = dateFormatter.string(from: convertedDate)
        return timeStamp
    }
    return ""
}
