//
//  UserDefaults.swift
//  Newstagram
//
//  Created by Grzegorz Surma on 30/03/2018.
//  Copyright © 2018 Grzegorz Surma. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    enum Key: String {
        case DefaultLocale = "DefaultLocale"
        case DefaultCategory = "DefaultCategory"
        case LastRefreshTimestamp = "LastRefreshTimestamp"
    }
    
    func getDefaultLocale() -> String {
        return UserDefaults.standard.string(forKey: Key.DefaultLocale.rawValue) ?? defaultLocale
    }
    
    func setDefaultLocale(locale: String) {
        UserDefaults.standard.set(locale, forKey: Key.DefaultLocale.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    func getDefaultCategory() -> String {
        return UserDefaults.standard.string(forKey: Key.DefaultCategory.rawValue) ?? defaultCategory
    }
    
    func setDefaultCategory(category: String) {
        UserDefaults.standard.set(category, forKey: Key.DefaultCategory.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    func refreshAllowed() -> Bool {
        let lastRefreshTimestamp = self.lastRefreshTimestamp()
        if lastRefreshTimestamp == 0 {
            return true
        }
        return lastRefreshTimestamp + oneHour < Date().timeIntervalSince1970
    }
    
    func setLastRefreshTimestamp() {
        UserDefaults.standard.set(Date().timeIntervalSince1970, forKey: Key.LastRefreshTimestamp.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    private func lastRefreshTimestamp() -> TimeInterval {
        return UserDefaults.standard.double(forKey: Key.LastRefreshTimestamp.rawValue)
    }
}
