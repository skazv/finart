//
//  UserDefaultsManager.swift
//  Finart
//
//  Created by Suren Kazaryan on 02.05.2022.
//

import Foundation

struct UserDefaultsManager {
    private init() {}
    public static let shared = UserDefaultsManager()
    
    static func saveDateUserDefaults(date: Date) {
        UserDefaults.standard.set(date, forKey: UserDefaultsKeys.reportDay.rawValue)
    }
    
    static func getDateUserDefaults() -> Date {
        let date: Date = UserDefaults.standard.object(forKey: UserDefaultsKeys.reportDay.rawValue) as? Date ?? Date()
        return date
    }
    
    static func getDaysUserDefaults() -> [Date] {
        let calendar = Calendar.current
        let start = getDateUserDefaults()
        let end = Date()
        
        if start > end {
            return [Date]()
        }
        
        var tempDay = start
        var days = [tempDay]
        
        while tempDay < end {
            tempDay = Calendar.current.date(byAdding: .day, value: 1, to: tempDay)!
            if calendar.dateComponents([.day], from: tempDay).day == calendar.dateComponents([.day], from: start).day {
                days.removeAll()
            }
            days.append(tempDay)
        }

        return days
    }
    
    static func incomeBalanceReportDay(incomeTransactions: [TransactionCD]) -> Int {
        let calendar = Calendar.current
        let reportDayArr = getDaysUserDefaults()
        var incomeBalance = 0
        
        incomeTransactions.forEach { transaction in
            guard let incomDate = transaction.date else { return }
            
            reportDayArr.forEach { day in
                if calendar.dateComponents([.day], from: incomDate) == calendar.dateComponents([.day], from: day) {
                    incomeBalance += Int(transaction.count)
                }
            }
            
        }
        return incomeBalance
    }
    
    static func spendingBalanceReportDay(spendingTransactions: [TransactionCD]) -> Int {
        let calendar = Calendar.current
        let reportDayArr = getDaysUserDefaults()
        var spendingBalance = 0
        
        spendingTransactions.forEach { transaction in
            guard let spendingDate = transaction.date else { return }
            
            reportDayArr.forEach { day in
                if calendar.dateComponents([.day], from: spendingDate) == calendar.dateComponents([.day], from: day) {
                    spendingBalance += Int(transaction.count)
                }
            }
            
        }
        return spendingBalance
    }

    static func firstLoadSettings() -> Bool {
        let isSecondLoad = UserDefaults.standard.bool(forKey: UserDefaultsKeys.isSecondLoad.rawValue)
        if isSecondLoad == false {
            setStartBudget(id: 0)
            UserDefaults.standard.set(true, forKey: UserDefaultsKeys.isSecondLoad.rawValue)
            return true
        }
        return false
    }
    
    static func setStartBudget(id: Int) {
        UserDefaults.standard.set(id, forKey: UserDefaultsKeys.budget.rawValue)
    }
    
    static func getStartBudget() -> Int {
        var startBudgetId = 0
        startBudgetId = UserDefaults.standard.integer(forKey: UserDefaultsKeys.budget.rawValue)
        return startBudgetId
    }
    
}
