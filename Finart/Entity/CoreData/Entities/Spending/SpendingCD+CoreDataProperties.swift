//
//  SpendingCD+CoreDataProperties.swift
//  Finart
//
//  Created by Suren Kazaryan on 13.05.2022.
//
//

import Foundation
import CoreData


extension SpendingCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SpendingCD> {
        return NSFetchRequest<SpendingCD>(entityName: "SpendingCD")
    }

    @NSManaged public var planCount: Int64
    @NSManaged public var currency: String?
    @NSManaged public var icon: String?
    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var color: String?
    @NSManaged public var budget: BudgetCD?
    @NSManaged public var transactions: NSSet?

}

// MARK: Generated accessors for transactions
extension SpendingCD {

    @objc(addTransactionsObject:)
    @NSManaged public func addToTransactions(_ value: TransactionCD)

    @objc(removeTransactionsObject:)
    @NSManaged public func removeFromTransactions(_ value: TransactionCD)

    @objc(addTransactions:)
    @NSManaged public func addToTransactions(_ values: NSSet)

    @objc(removeTransactions:)
    @NSManaged public func removeFromTransactions(_ values: NSSet)

}

extension SpendingCD : Identifiable {

}
