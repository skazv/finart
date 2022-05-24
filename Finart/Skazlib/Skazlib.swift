//
//  Skazlib.swift
//  Finart
//
//  Created by Suren Kazaryan on 03.05.2022.
//

import Foundation
import UIKit

//MARK: - Date -
public func giveAppCreatingDate() -> Date {
    let calendar = Calendar.current
    let dateComponent = DateComponents(year: 2022, month: 4, day: 1)
    let date = calendar.date(from: dateComponent)
    return date ?? Date()
}

public func getDays(reportDate: Date) -> [Date] {
    let calendar = Calendar.current
    let start = reportDate
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

public func incomeBalanceReportDay(reportDate: Date, incomeTransactions: [TransactionCD]) -> Int {
    let calendar = Calendar.current
    let reportDayArr = getDays(reportDate: reportDate)
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

func incomeBalanceByCurrency(mainCurrency: String, incomeViewModel: IncomeViewModel, currencyRaw: CurrencyRaw) -> Int {
    var incomeBalance = 0
    
    switch mainCurrency {
    case "RUB":
        incomeBalance = incomeViewModel.count * 60
    default:
        print("incomeBalanceByCurrency error")
    }
    
    return incomeBalance
}

private func currencyByRub() {
    
}

public func spendingBalanceReportDay(reportDate: Date, spendingTransactions: [TransactionCD]) -> Int {
    let calendar = Calendar.current
    let reportDayArr = getDays(reportDate: reportDate)
    var spendingBalance = 0
    
    spendingTransactions.forEach { transaction in
        guard let spendingDate = transaction.date else { return }
        guard let accountCD = transaction.accountTransaction else { return }
        guard let spendingCD = transaction.spendingTransaction else { return }
        
        reportDayArr.forEach { day in
            if calendar.dateComponents([.day], from: spendingDate) == calendar.dateComponents([.day], from: day) {
                if isSameCurrency(accountCD: accountCD, spendingCD: spendingCD) {
                    spendingBalance += Int(transaction.count)
                } else {
                    spendingBalance += Int(transaction.secondCount)
                }
            }
        }
        
    }
    return spendingBalance
}


//MARK: - Currency -

//MARK: - currencyFormat
public func currencyFormat(number: Int) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = NumberFormatter.Style.decimal
    
    let amount = number
    let formattedString = formatter.string(for: amount)
    
    return formattedString ?? "\(number)"
}

func giveCurrencyVM(currency: String) -> CurrencyViewModel {
    var currencyViewModel = CurrencyViewModel(shortName: "RUB", name: "Российский рубль", symbol: "₽")
    switch currency {
    case "RUB":
        currencyViewModel = CurrencyViewModel(shortName: "RUB", name: "Российский рубль", symbol: "₽")
    case "USD":
        currencyViewModel =  CurrencyViewModel(shortName: "USD", name: "Американский доллар", symbol: "$")
    case "EUR":
        currencyViewModel = CurrencyViewModel(shortName: "EUR", name: "Евро", symbol: "€")
    case "AMD":
        currencyViewModel = CurrencyViewModel(shortName: "AMD", name: "Армянский драм", symbol: "֏")
    default:
        print("giveCurrencyVM Error")
    }
    return currencyViewModel
}


//MARK: - Image -
public func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
    let size = image.size
    
    let widthRatio  = targetSize.width  / size.width
    let heightRatio = targetSize.height / size.height
    
    // Figure out what our orientation is, and use that to form the rectangle
    var newSize: CGSize
    if(widthRatio > heightRatio) {
        newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
    } else {
        newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
    }
    
    // This is the rect that we've calculated out and this is what is actually used below
    let rect = CGRect(origin: .zero, size: newSize)
    
    // Actually do the resizing to the rect using the ImageContext stuff
    UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
    image.draw(in: rect)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage
}



//MARK: - From CoreData to ViewModels -
func incomeCDtoIncomeVM(incomeCD: IncomeCD) -> IncomeViewModel {
    var income = IncomeViewModel(name: "", count: 0, planCount: 0, icon: .checkmark, currency: "USD")
    guard let name = incomeCD.name else { return income }
    guard let iconName = incomeCD.icon else { return income }
    guard let image = UIImage(systemName: iconName) else { return income }
    let count = CoreDataManager.giveRealCount(incomeCD: incomeCD)
    guard let currency = incomeCD.currency else { return income }
    
    income = IncomeViewModel(name: name,
                             count: count,
                             planCount: Int(incomeCD.planCount),
                             icon: image,
                             currency: currency)
    return income
}

func accountCDtoAccountVM(accountCD: AccountCD) -> AccountViewModel {
    var account = AccountViewModel(name: "", count: 0, icon: .checkmark, currency: "USD")
    guard let name = accountCD.name else { return account }
    guard let iconName = accountCD.icon else { return account }
    guard let image = UIImage(systemName: iconName) else { return account }
    let count = Int(accountCD.count)
    guard let currency = accountCD.currency else { return account }
    
    account = AccountViewModel(name: name,
                             count: count,
                               icon: image,
                               currency: currency)
    return account
}

func spendingCDtoSpendingVM(spendingCD: SpendingCD) -> SpendingViewModel {
    var spending = SpendingViewModel(name: "", count: 0, planCount: 0, icon: .checkmark, currency: "USD")
    guard let name = spendingCD.name else { return spending }
    guard let iconName = spendingCD.icon else { return spending }
    guard let image = UIImage(systemName: iconName) else { return spending }
    let count = CoreDataManager.giveRealCount(spendingCD: spendingCD)
    guard let currency = spendingCD.currency else { return spending }
    
    spending = SpendingViewModel(name: name,
                             count: count,
                             planCount: Int(spendingCD.planCount),
                                 icon: image,
                                 currency: currency)
    return spending
}

func budgetCDtobudgetVM(budgetCD: BudgetCD) -> BudgetViewModel {
    var budget = BudgetViewModel(name: "", icon: .checkmark, reportDay: Date(), currency: "USD")
    guard let name = budgetCD.name else { return budget }
    guard let iconName = budgetCD.icon else { return budget }
    guard let image = UIImage(systemName: iconName) else { return budget }
    guard let reportDate = budgetCD.reportDate else { return budget }
    guard let currency = budgetCD.currency else { return budget }
    
    budget = BudgetViewModel(name: name,
                             icon: image,
                             reportDay: reportDate,
                             currency: currency)
    return budget
}

func getBudget(budgetId: Int) -> BudgetCD {
    let budgetsCD = try? CoreDataManager.fetchBudgets()
    if let budgetsCD = budgetsCD {
        let budgetCD = budgetsCD[budgetId]
        return budgetCD
    }
    return BudgetCD()
}
//MARK: - CoreData transaction check -
func isSameCurrency(budgetId: Int, cellType: CellType, from: Int, to: Int) -> Bool {
    var isSameCurrency = false
    guard let budgets = try? CoreDataManager.fetchBudgets() else { return false }
    
    switch cellType {
    case .income:
        guard let incomes = try? CoreDataManager.fetchIncomesByBudget(budget: budgets[budgetId]) else { return false }
        guard let accounts = try? CoreDataManager.fetchAccountsByBudget(budget: budgets[budgetId]) else { return false }
        if incomes[from].currency == accounts[to].currency {
            isSameCurrency = true
        }
    case .account:
        guard let accounts = try? CoreDataManager.fetchAccountsByBudget(budget: budgets[budgetId]) else { return false }
        if accounts[from].currency == accounts[to].currency {
            isSameCurrency = true
        }
    case .spending:
        guard let accounts = try? CoreDataManager.fetchAccountsByBudget(budget: budgets[budgetId]) else { return false }
        guard let spendings = try? CoreDataManager.fetchSpendingsByBudget(budget: budgets[budgetId]) else { return false }
        if accounts[from].currency == spendings[to].currency {
            isSameCurrency = true
        }
    }
    return isSameCurrency
}

func isSameCurrency(incomCD: IncomeCD, accountCD: AccountCD) -> Bool {
    var isSameCurrency = false
    if incomCD.currency == accountCD.currency {
        isSameCurrency = true
    }
    return isSameCurrency
}

func isSameCurrency(accountCD: AccountCD, accountDestCD: AccountCD) -> Bool {
    var isSameCurrency = false
    if accountCD.currency == accountDestCD.currency {
        isSameCurrency = true
    }
    return isSameCurrency
}

func isSameCurrency(accountCD: AccountCD, spendingCD: SpendingCD) -> Bool {
    var isSameCurrency = false
    if accountCD.currency == spendingCD.currency {
        isSameCurrency = true
    }
    return isSameCurrency
}


//MARK: - Alarm -
public func showAlarm(navigation: UIViewController, title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
    navigation.present(alert, animated: true, completion: nil)
}
