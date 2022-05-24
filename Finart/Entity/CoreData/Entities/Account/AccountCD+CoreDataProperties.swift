//
//  AccountCD+CoreDataProperties.swift
//  Finart
//
//  Created by Suren Kazaryan on 13.05.2022.
//
//

import Foundation
import CoreData


extension AccountCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AccountCD> {
        return NSFetchRequest<AccountCD>(entityName: "AccountCD")
    }

    @NSManaged public var count: Int64
    @NSManaged public var currency: String?
    @NSManaged public var icon: String?
    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var color: String?
    @NSManaged public var budget: BudgetCD?
    @NSManaged public var transactions: NSSet?
    @NSManaged public var transactionsDestination: NSSet?

}

// MARK: Generated accessors for transactions
extension AccountCD {

    @objc(addTransactionsObject:)
    @NSManaged public func addToTransactions(_ value: TransactionCD)

    @objc(removeTransactionsObject:)
    @NSManaged public func removeFromTransactions(_ value: TransactionCD)

    @objc(addTransactions:)
    @NSManaged public func addToTransactions(_ values: NSSet)

    @objc(removeTransactions:)
    @NSManaged public func removeFromTransactions(_ values: NSSet)

}

// MARK: Generated accessors for transactionsDestination
extension AccountCD {

    @objc(addTransactionsDestinationObject:)
    @NSManaged public func addToTransactionsDestination(_ value: TransactionCD)

    @objc(removeTransactionsDestinationObject:)
    @NSManaged public func removeFromTransactionsDestination(_ value: TransactionCD)

    @objc(addTransactionsDestination:)
    @NSManaged public func addToTransactionsDestination(_ values: NSSet)

    @objc(removeTransactionsDestination:)
    @NSManaged public func removeFromTransactionsDestination(_ values: NSSet)

}

extension AccountCD : Identifiable {

}
