//
//  BudgetCD+CoreDataProperties.swift
//  Finart
//
//  Created by Suren Kazaryan on 13.05.2022.
//
//

import Foundation
import CoreData


extension BudgetCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BudgetCD> {
        return NSFetchRequest<BudgetCD>(entityName: "BudgetCD")
    }

    @NSManaged public var backgroundColor: String?
    @NSManaged public var currency: String?
    @NSManaged public var icon: String?
    @NSManaged public var id: Int64
    @NSManaged public var incomeBackgroundColor: String?
    @NSManaged public var incomesColor: String?
    @NSManaged public var isMain: Bool
    @NSManaged public var name: String?
    @NSManaged public var reportDate: Date?
    @NSManaged public var spendingBackgroundColor: String?
    @NSManaged public var spendingsColor: String?
    @NSManaged public var accounts: NSSet?
    @NSManaged public var incomes: NSSet?
    @NSManaged public var spendings: NSSet?

}

// MARK: Generated accessors for accounts
extension BudgetCD {

    @objc(addAccountsObject:)
    @NSManaged public func addToAccounts(_ value: AccountCD)

    @objc(removeAccountsObject:)
    @NSManaged public func removeFromAccounts(_ value: AccountCD)

    @objc(addAccounts:)
    @NSManaged public func addToAccounts(_ values: NSSet)

    @objc(removeAccounts:)
    @NSManaged public func removeFromAccounts(_ values: NSSet)

}

// MARK: Generated accessors for incomes
extension BudgetCD {

    @objc(addIncomesObject:)
    @NSManaged public func addToIncomes(_ value: IncomeCD)

    @objc(removeIncomesObject:)
    @NSManaged public func removeFromIncomes(_ value: IncomeCD)

    @objc(addIncomes:)
    @NSManaged public func addToIncomes(_ values: NSSet)

    @objc(removeIncomes:)
    @NSManaged public func removeFromIncomes(_ values: NSSet)

}

// MARK: Generated accessors for spendings
extension BudgetCD {

    @objc(addSpendingsObject:)
    @NSManaged public func addToSpendings(_ value: SpendingCD)

    @objc(removeSpendingsObject:)
    @NSManaged public func removeFromSpendings(_ value: SpendingCD)

    @objc(addSpendings:)
    @NSManaged public func addToSpendings(_ values: NSSet)

    @objc(removeSpendings:)
    @NSManaged public func removeFromSpendings(_ values: NSSet)

}

extension BudgetCD : Identifiable {

}
