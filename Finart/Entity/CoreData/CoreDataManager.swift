//
//  CoreDataManager.swift
//  Finart
//
//  Created by Suren Kazaryan on 24.04.2022.
//

import CoreData
import UIKit

//WTF? Delete
enum UpdateSetup: String {
    case deletePerson
    case changeSection
}

class CoreDataManager {
    
    private init() {}
    public static let shared = CoreDataManager()
    
    static func fetchBudgets() throws -> [BudgetCD] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { throw CoreDataErrors.contextNotFound }
        let context = appDelegate.persistentContainer.viewContext
        
        var budgets = [BudgetCD]()
        
        let fetchRequest = NSFetchRequest<BudgetCD>(entityName: "BudgetCD")
        let sort = NSSortDescriptor(key: "id", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        
        do {
            budgets = try context.fetch(fetchRequest)
        } catch {
            print(error)
        }
        
        return budgets
        
    }
    
    static func fetchIncomesByBudget(budget: BudgetCD) throws -> [IncomeCD] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { throw CoreDataErrors.contextNotFound }
        let context = appDelegate.persistentContainer.viewContext
        
        var incomes = [IncomeCD]()
        
        let fetchRequest = NSFetchRequest<IncomeCD>(entityName: "IncomeCD")
        let sort = NSSortDescriptor(key: "id", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        let predicate = NSPredicate(format: "budget = %@", budget)
        fetchRequest.predicate = predicate
        
        do {
            incomes = try context.fetch(fetchRequest)
        } catch {
            print(error)
        }
        
        return incomes
        
    }
    
    static func fetchAccountsByBudget(budget: BudgetCD) throws -> [AccountCD] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { throw CoreDataErrors.contextNotFound }
        let context = appDelegate.persistentContainer.viewContext
        
        var accounts = [AccountCD]()
        
        let fetchRequest = NSFetchRequest<AccountCD>(entityName: "AccountCD")
        let sort = NSSortDescriptor(key: "id", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        let predicate = NSPredicate(format: "budget = %@", budget)
        fetchRequest.predicate = predicate
        
        do {
            accounts = try context.fetch(fetchRequest)
        } catch {
            print(error)
        }
        
        return accounts
        
    }
    
    static func fetchSpendingsByBudget(budget: BudgetCD) throws -> [SpendingCD] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { throw CoreDataErrors.contextNotFound }
        let context = appDelegate.persistentContainer.viewContext
        
        var spendings = [SpendingCD]()
        
        let fetchRequest = NSFetchRequest<SpendingCD>(entityName: "SpendingCD")
        let sort = NSSortDescriptor(key: "id", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        let predicate = NSPredicate(format: "budget = %@", budget)
        fetchRequest.predicate = predicate
        
        do {
            spendings = try context.fetch(fetchRequest)
        } catch {
            print(error)
        }
                
        return spendings
        
    }
    
    static func fetchTransactions() throws -> [TransactionCD] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { throw CoreDataErrors.contextNotFound }
        let context = appDelegate.persistentContainer.viewContext
        
        var transactions = [TransactionCD]()
        
        let fetchRequest = NSFetchRequest<TransactionCD>(entityName: "TransactionCD")
        let sort = NSSortDescriptor(key: "id", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        
        do {
            transactions = try context.fetch(fetchRequest)
        } catch {
            print(error)
        }
        
        return transactions
        
    }
    
    static func fetchTransactions(income: IncomeCD) throws -> [TransactionCD] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { throw CoreDataErrors.contextNotFound }
        let context = appDelegate.persistentContainer.viewContext
        
        var transactions = [TransactionCD]()
        
        let fetchRequest = NSFetchRequest<TransactionCD>(entityName: "TransactionCD")
        let sort = NSSortDescriptor(key: "date", ascending: false)
        fetchRequest.sortDescriptors = [sort]
        let predicate = NSPredicate(format: "incomeTransaction = %@", income)
        fetchRequest.predicate = predicate
        
        do {
            transactions = try context.fetch(fetchRequest)
        } catch {
            print(error)
        }
        return transactions
    }
    
    static func fetchTransactions(account: AccountCD) throws -> [TransactionCD] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { throw CoreDataErrors.contextNotFound }
        let context = appDelegate.persistentContainer.viewContext
        
        var transactions = [TransactionCD]()
        
        let fetchRequest = NSFetchRequest<TransactionCD>(entityName: "TransactionCD")
        let sort = NSSortDescriptor(key: "date", ascending: false)
        fetchRequest.sortDescriptors = [sort]
        let predicate = NSPredicate(format: "accountTransaction = %@", account)
        fetchRequest.predicate = predicate
        
        do {
            transactions = try context.fetch(fetchRequest)
        } catch {
            print(error)
        }

        return transactions
    }
    
    static func fetchTransactions(accountDestination: AccountCD) throws -> [TransactionCD] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { throw CoreDataErrors.contextNotFound }
        let context = appDelegate.persistentContainer.viewContext
        
        var transactions = [TransactionCD]()
        
        let fetchRequest = NSFetchRequest<TransactionCD>(entityName: "TransactionCD")
        let sort = NSSortDescriptor(key: "date", ascending: false)
        fetchRequest.sortDescriptors = [sort]
        let predicate = NSPredicate(format: "accountDestination = %@", accountDestination)
        fetchRequest.predicate = predicate
        
        do {
            transactions = try context.fetch(fetchRequest)
        } catch {
            print(error)
        }

        return transactions
    }
    
    static func fetchTransactions(spending: SpendingCD) throws -> [TransactionCD] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { throw CoreDataErrors.contextNotFound }
        let context = appDelegate.persistentContainer.viewContext
        
        var transactions = [TransactionCD]()
        
        let fetchRequest = NSFetchRequest<TransactionCD>(entityName: "TransactionCD")
        let sort = NSSortDescriptor(key: "date", ascending: false)
        fetchRequest.sortDescriptors = [sort]
        let predicate = NSPredicate(format: "spendingTransaction = %@", spending)
        fetchRequest.predicate = predicate
        
        do {
            transactions = try context.fetch(fetchRequest)
        } catch {
            print(error)
        }
        return transactions
    }
    
    static func fetchTransactions(identificator: UUID) throws -> TransactionCD {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { throw CoreDataErrors.contextNotFound }
        let context = appDelegate.persistentContainer.viewContext
        
        var transactions = [TransactionCD]()
        
        let fetchRequest = NSFetchRequest<TransactionCD>(entityName: "TransactionCD")
        let predicate = NSPredicate(format: "identificator = %@", identificator as CVarArg)
        fetchRequest.predicate = predicate
        
        do {
            transactions = try context.fetch(fetchRequest)
        } catch {
            print(error)
        }
        
        if let transaction = transactions.first {
            return transaction
        }
        
        return TransactionCD()
    }

}

//MARK: - IncomeCD
extension CoreDataManager {
    
    static func createIncomeByBudget(budget: BudgetCD, name: String, count: Int, icon: String, currency: String) throws -> IncomeCD {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { throw CoreDataErrors.contextNotFound }
        let context = appDelegate.persistentContainer.viewContext

        let incomes = try fetchIncomesByBudget(budget: budget)
        
        let newIncome = IncomeCD(context: context)
        newIncome.name = name
        newIncome.planCount = Int64(count)
        newIncome.icon = icon
        newIncome.currency = currency
        
        budget.addToIncomes(newIncome)
        newIncome.budget = budget
        
        if incomes.isEmpty {
            newIncome.id = 0
        } else {
            newIncome.id = (incomes.last?.id ?? 0) + 1
        }
          
        do {
            try context.save()
        } catch {
            print(error)
        }
        
        return newIncome

    }

    static func deleteIncome(budget: BudgetCD, with row: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext

        guard let incomes = try? CoreDataManager.fetchIncomesByBudget(budget: budget) else { return }
        
        incomes.forEach { income in
            if income.id > Int64(row) {
                income.id -= 1
            }
        }

        context.delete(incomes[row])
        do {
            try context.save()
        } catch {
            print(error)
        }
        
    }
    
    static func moveIncome(budget: BudgetCD, source: Int, destination: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        guard let incomes = try? CoreDataManager.fetchIncomesByBudget(budget: budget) else { return }

        if source < destination {
            incomes.forEach { income in
                if Int(income.id) > source && Int(income.id) <= destination {
                    income.id -= 1
                }
            }
            incomes[source].id = Int64(destination)
        } else if destination < source {
            incomes.forEach { income in
                if Int(income.id) >= destination && Int(income.id) < source {
                    income.id += 1
                }
            }
            incomes[source].id = Int64(destination)
        }
        
        do {
            try context.save()
        } catch {
            print(error)
        }
        
    }
    
    static func updateIncome(budget: BudgetCD, row: Int, name: String?, count: Int?, icon: String?) throws -> IncomeCD {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { throw CoreDataErrors.contextNotFound }
        let context = appDelegate.persistentContainer.viewContext

        let incomes = try CoreDataManager.fetchIncomesByBudget(budget: budget)
        
        let updateIncome = incomes[row]
        
        if name != nil {
            updateIncome.name = name
        }
        if let count = count {
            updateIncome.planCount = Int64(count)
        }
        if icon != nil {
            updateIncome.icon = icon
        }
          
        do {
            try context.save()
        } catch {
            print(error)
        }
        return incomes[row]
    }

}

//MARK: - AccountCD
extension CoreDataManager {
    
    static func createAccountByBudget(budget: BudgetCD, name: String, count: Int, icon: String, currency: String) throws -> AccountCD {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { throw CoreDataErrors.contextNotFound }
        let context = appDelegate.persistentContainer.viewContext

        let accounts = try fetchAccountsByBudget(budget: budget)
        
        let newAccount = AccountCD(context: context)
        newAccount.name = name
        newAccount.count = Int64(count)
        newAccount.icon = icon
        newAccount.currency = currency
        
        budget.addToAccounts(newAccount)
        newAccount.budget = budget
        
        if accounts.isEmpty {
            newAccount.id = 0
        } else {
            newAccount.id = (accounts.last?.id ?? 0) + 1
        }
          
        do {
            try context.save()
        } catch {
            print(error)
        }
        
        return newAccount

    }

    static func deleteAccount(budget: BudgetCD, with row: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext

        guard let accounts = try? CoreDataManager.fetchAccountsByBudget(budget: budget) else { return }
        
        accounts.forEach { account in
            if account.id > Int64(row) {
                account.id -= 1
            }
        }

        context.delete(accounts[row])
        do {
            try context.save()
        } catch {
            print(error)
        }
        
    }
    
    static func moveAccount(budget: BudgetCD, source: Int, destination: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        guard let accounts = try? CoreDataManager.fetchAccountsByBudget(budget: budget) else { return }

        if source < destination {
            accounts.forEach { account in
                if Int(account.id) > source && Int(account.id) <= destination {
                    account.id -= 1
                }
            }
            accounts[source].id = Int64(destination)
        } else if destination < source {
            accounts.forEach { account in
                if Int(account.id) >= destination && Int(account.id) < source {
                    account.id += 1
                }
            }
            accounts[source].id = Int64(destination)
        }
        
        do {
            try context.save()
        } catch {
            print(error)
        }
        
    }
    
    static func updateAccount(budget: BudgetCD, row: Int, name: String?, count: Int?, icon: String?) throws -> AccountCD {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { throw CoreDataErrors.contextNotFound }
        let context = appDelegate.persistentContainer.viewContext

        let accounts = try fetchAccountsByBudget(budget: budget)
        
        let updateAccount = accounts[row]
        
        if name != nil {
            updateAccount.name = name
        }
        if let count = count {
            updateAccount.count = Int64(count)
        }
        if icon != nil {
            updateAccount.icon = icon
        }
          
        do {
            try context.save()
        } catch {
            print(error)
        }
        return accounts[row]
    }

}

//MARK: - SpendingCD
extension CoreDataManager {
    
    static func createSpendingByBudget(budget: BudgetCD, name: String, count: Int, icon: String, currency: String) throws -> SpendingCD {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { throw CoreDataErrors.contextNotFound }
        let context = appDelegate.persistentContainer.viewContext

        let spendings = try fetchSpendingsByBudget(budget: budget)
        let newSpending = SpendingCD(context: context)
        newSpending.name = name
        newSpending.planCount = Int64(count)
        newSpending.icon = icon
        newSpending.currency = currency
        
        budget.addToSpendings(newSpending)
        newSpending.budget = budget
        
        if spendings.isEmpty {
            newSpending.id = 0
        } else {
            newSpending.id = (spendings.last?.id ?? 0) + 1
        }
          
        do {
            try context.save()
        } catch {
            print(error)
        }
        return newSpending

    }

    static func deleteSpending(budget: BudgetCD, with row: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext

        guard let spendings = try? CoreDataManager.fetchSpendingsByBudget(budget: budget) else { return }
        
        spendings.forEach { spending in
            if spending.id > Int64(row) {
                spending.id -= 1
            }
        }

        context.delete(spendings[row])
        do {
            try context.save()
        } catch {
            print(error)
        }
        
    }
    
    static func moveSpending(budget: BudgetCD, source: Int, destination: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        guard let spendings = try? CoreDataManager.fetchSpendingsByBudget(budget: budget) else { return }

        if source < destination {
            spendings.forEach { spending in
                if Int(spending.id) > source && Int(spending.id) <= destination {
                    spending.id -= 1
                }
            }
            spendings[source].id = Int64(destination)
        } else if destination < source {
            spendings.forEach { spending in
                if Int(spending.id) >= destination && Int(spending.id) < source {
                    spending.id += 1
                }
            }
            spendings[source].id = Int64(destination)
        }
        
        do {
            try context.save()
        } catch {
            print(error)
        }
        
    }
    
    static func updateSpending(budget: BudgetCD, row: Int, name: String?, count: Int?, icon: String?) throws -> SpendingCD {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { throw CoreDataErrors.contextNotFound }
        let context = appDelegate.persistentContainer.viewContext

        let spendings = try fetchSpendingsByBudget(budget: budget)
        
        let updateSpending = spendings[row]
        
        if name != nil {
            updateSpending.name = name
        }
        if let count = count {
            updateSpending.planCount = Int64(count)
        }
        if icon != nil {
            updateSpending.icon = icon
        }
          
        do {
            try context.save()
        } catch {
            print(error)
        }
        
        return spendings[row]

    }

}

//MARK: - TransactionCD
extension CoreDataManager {

    static func createTransaction(income: IncomeCD, account: AccountCD, name: String, count: Int, secondCount: Int?, date: Date) throws -> TransactionCD {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { throw CoreDataErrors.contextNotFound }
        let context = appDelegate.persistentContainer.viewContext

        let transactions = try fetchTransactions(income: income)
        
        let newTransaction = TransactionCD(context: context)
        newTransaction.name = name
        newTransaction.count = Int64(count)
        if let secondCount = secondCount {
            newTransaction.secondCount = Int64(secondCount)
        }
        newTransaction.date = date
        newTransaction.identificator = UUID()
        
        newTransaction.incomeTransaction = income
        newTransaction.accountTransaction = account
        
        income.addToTransactions(newTransaction) // Delete?
        account.addToTransactions(newTransaction) //Delete?
        
        if transactions.isEmpty {
            newTransaction.id = 0
        } else {
            newTransaction .id = (transactions.last?.id ?? 0) + 1
        }
        do {
            try context.save()
        } catch {
            print(error)
        }

        return newTransaction
    }
    
    static func createTransaction(accountSource: AccountCD, accountDestination: AccountCD, name: String, count: Int, secondCount: Int?, date: Date) throws -> TransactionCD {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { throw CoreDataErrors.contextNotFound }
        let context = appDelegate.persistentContainer.viewContext
        
        let transactions = try fetchTransactions(account: accountSource)
        
        let newTransaction = TransactionCD(context: context)
        newTransaction.name = name
        newTransaction.count = Int64(count)
        if let secondCount = secondCount {
            newTransaction.secondCount = Int64(secondCount)
        }
        newTransaction.date = date
        newTransaction.identificator = UUID()

        newTransaction.accountTransaction = accountSource
        newTransaction.accountDestination = accountDestination
        
        accountSource.addToTransactions(newTransaction)
        accountDestination.addToTransactionsDestination(newTransaction)
        
        if transactions.isEmpty {
            newTransaction.id = 0
        } else {
            newTransaction .id = (transactions.last?.id ?? 0) + 1
        }
        do {
            try context.save()
        } catch {
            print(error)
        }

//        print("Source \(newTransaction.accountTransaction?.name)")
//        print("Destination \(newTransaction.accountDestination?.name)")
        
        return newTransaction
    }

    static func createTransaction(account: AccountCD, spending: SpendingCD, name: String, count: Int, secondCount: Int?, date: Date) throws -> TransactionCD {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { throw CoreDataErrors.contextNotFound }
        let context = appDelegate.persistentContainer.viewContext

        let transactions = try fetchTransactions(account: account)
        
        let newTransaction = TransactionCD(context: context)
        newTransaction.name = name
        newTransaction.count = Int64(count)
        if let secondCount = secondCount {
            newTransaction.secondCount = Int64(secondCount)
        }
        newTransaction.date = date
        newTransaction.identificator = UUID()

        newTransaction.accountTransaction = account // Delete?
        newTransaction.spendingTransaction = spending // Delete?
        
        account.addToTransactions(newTransaction)
        spending.addToTransactions(newTransaction)
        
        if transactions.isEmpty {
            newTransaction.id = 0
        } else {
            newTransaction .id = (transactions.last?.id ?? 0) + 1
        }
        do {
            try context.save()
        } catch {
            print(error)
        }
        return newTransaction
    }
    
    
//    static func deleteTransaction(identificator: UUID) {
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//        let context = appDelegate.persistentContainer.viewContext
//        
//        guard let transaction = try? CoreDataManager.fetchTransactions(identificator: identificator) else { return }
//
//        context.delete(transaction)
//        do {
//            try context.save()
//        } catch {
//            print(error)
//        }
//    }
    
    static func deleteTransaction(identificator: UUID) -> Int {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return 0 }
        let context = appDelegate.persistentContainer.viewContext
        
        guard let transaction = try? CoreDataManager.fetchTransactions(identificator: identificator) else { return 0 }
        let count = Int(transaction.count)
        
        if transaction.incomeTransaction != nil {
            guard let budgetId = transaction.incomeTransaction?.budget?.id else { return 0 }
            guard let incomeId = transaction.incomeTransaction?.id else { return 0 }
            guard let accountID = transaction.accountTransaction?.id else { return 0 }
            if isSameCurrency(budgetId: Int(budgetId), cellType: .income, from: Int(incomeId), to: Int(accountID)) {
                transaction.accountTransaction?.count -= transaction.count
            } else {
                transaction.accountTransaction?.count -= transaction.secondCount
            }
        } else if transaction.spendingTransaction != nil {
            guard let budgetId = transaction.spendingTransaction?.budget?.id else { return 0 }
            guard let spendingId = transaction.spendingTransaction?.id else { return 0 }
            guard let accountID = transaction.accountTransaction?.id else { return 0 }
            if isSameCurrency(budgetId: Int(budgetId), cellType: .spending, from: Int(accountID), to: Int(spendingId)) {
                transaction.accountTransaction?.count += transaction.count
            } else {
                print("Different")
            }
        } else {
            guard let budgetId = transaction.accountTransaction?.budget?.id else { return 0 }
            guard let accountID = transaction.accountTransaction?.id else { return 0 }
            guard let accountDestinationID = transaction.accountDestination?.id else { return 0 }
            
            if isSameCurrency(budgetId: Int(budgetId), cellType: .account, from: Int(accountID), to: Int(accountDestinationID)) {
                transaction.accountTransaction?.count += transaction.count
                transaction.accountDestination?.count -= transaction.count
            } else {
                transaction.accountTransaction?.count += transaction.count
                transaction.accountDestination?.count -= transaction.secondCount
            }
        }

        context.delete(transaction)
        do {
            try context.save()
        } catch {
            print(error)
        }
        return count
    }
    
    static func giveRealCount(budget: BudgetCD, row: Int, cellType: CellType) -> Int {
        var count = 0
        switch cellType {
        case .income:
            let incomes = try? CoreDataManager.fetchIncomesByBudget(budget: budget)
            guard let incomes = incomes else { return 0 }
            if let transactions = try? CoreDataManager.fetchTransactions(income: incomes[row]) {
                count = UserDefaultsManager.incomeBalanceReportDay(incomeTransactions: transactions)
            }
        case .account:
            print("Account not provides realCount")
        case .spending:
            let spendings = try? CoreDataManager.fetchSpendingsByBudget(budget: budget)
            guard let spendings = spendings else { return 0 }
            if let transactions = try? CoreDataManager.fetchTransactions(spending: spendings[row]) {
                count = UserDefaultsManager.incomeBalanceReportDay(incomeTransactions: transactions)
            }
        }
        return count
    }
    
    static func giveRealCount(incomeCD: IncomeCD) -> Int {
        var count = 0
        guard let budget = incomeCD.budget else { return 0 }
        guard let reportDate = budget.reportDate else { return 0 }
        if let transactions = try? CoreDataManager.fetchTransactions(income: incomeCD) {
            count = incomeBalanceReportDay(reportDate: reportDate, incomeTransactions: transactions)
        }
        return count
    }
    
    static func giveRealCount(spendingCD: SpendingCD) -> Int {
        var count = 0
        guard let budget = spendingCD.budget else { return 0 }
        guard let reportDate = budget.reportDate else { return 0 }
        if let transactions = try? CoreDataManager.fetchTransactions(spending: spendingCD) {
            count = spendingBalanceReportDay(reportDate: reportDate, spendingTransactions: transactions)
        }
        return count
    }
    
//    static func giveRealCount(incomeCD: IncomeCD) -> Int {
//        var count = 0
//        if let transactions = try? CoreDataManager.fetchTransactions(income: incomeCD) {
//            count = UserDefaultsManager.incomeBalanceReportDay(incomeTransactions: transactions)
//        }
//        return count
//    }
//
//    static func giveRealCount(spendingCD: SpendingCD) -> Int {
//        var count = 0
//        if let transactions = try? CoreDataManager.fetchTransactions(spending: spendingCD) {
//            count = UserDefaultsManager.incomeBalanceReportDay(incomeTransactions: transactions)
//        }
//        return count
//    }
    
}



//MARK: - BudgetCD
extension CoreDataManager {
    
    static func createBudget(name: String, icon: String, reportDay: Date, currency: String) throws -> BudgetCD {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { throw CoreDataErrors.contextNotFound }
        let context = appDelegate.persistentContainer.viewContext

        let budgets = try fetchBudgets()

        let newBudget = BudgetCD(context: context)
        newBudget.name = name
        newBudget.icon = icon
        newBudget.reportDate = reportDay
        newBudget.currency = currency

        if budgets.isEmpty {
            newBudget.id = 0
        } else {
            newBudget.id = (budgets.last?.id ?? 0) + 1
        }

        do {
            try context.save()
        } catch {
            print(error)
        }

        return newBudget

    }
    
    static func deleteBudget(with row: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext

        guard let budgets = try? fetchBudgets() else { return }
        
        budgets.forEach { budget in
            if budget.id > Int64(row) {
                budget.id -= 1
            }
        }

        context.delete(budgets[row])
        
        do {
            try context.save()
        } catch {
            print(error)
        }
        
    }
    
    static func updateBudget(budget: BudgetCD, name: String, icon: String?, reportDay: Date, currency: String) throws -> BudgetCD {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { throw CoreDataErrors.contextNotFound }
        let context = appDelegate.persistentContainer.viewContext

        budget.name = name
        if let icon = icon {
            budget.icon = icon
        }
        budget.reportDate = reportDay
        budget.currency = currency

        do {
            try context.save()
        } catch {
            print(error)
        }

        return budget

    }
    
}
