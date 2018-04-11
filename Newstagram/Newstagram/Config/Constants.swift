//
//  Constants.swift
//  Newstagram
//
//  Created by Grzegorz Surma on 29/03/2018.
//  Copyright © 2018 Grzegorz Surma. All rights reserved.
//

import Foundation
import UIKit

let apiKey = "badecbdafe6a4be6a94086f2adfa9c06" // FIXME: set your own api key
let apiHost = "https://newsapi.org/v2/"
let apiPageSize = String(30)

let oneHour: TimeInterval = 60 * 60
let imageAspectRatio: CGFloat = 9 / 16

let defaultCategory = "General"
let categories = ["General",
                  "Sports",
                  "Technology",
                  "Business",
                  "Entertainment",
                  "Science",
                  "Health"]

var defaultLocale: String {
    let usLocale = "US"
    let locale = (NSLocale.current.languageCode ?? usLocale).uppercased()
    if locales.contains(locale) {
        return locale
    }
    return usLocale
}
let locales = ["AE",
               "AR",
               "AT",
               "AU",
               "BE",
               "BG",
               "BR",
               "CA",
               "CH",
               "CN",
               "CO",
               "CU",
               "CZ",
               "DE",
               "EG",
               "FR",
               "GB",
               "GR",
               "HK",
               "HU",
               "ID",
               "IE",
               "IL",
               "IN",
               "IT",
               "JP",
               "KR",
               "LT",
               "MA",
               "MX",
               "MY",
               "NG",
               "NL",
               "NO",
               "NZ",
               "PH",
               "PL",
               "PT",
               "RO",
               "RS",
               "RU",
               "SA",
               "SE",
               "SG",
               "SI",
               "SK",
               "TH",
               "TR",
               "TW",
               "UA",
               "US",
               "VE",
               "ZE"]



