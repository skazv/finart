//
//  TransactionCD+CoreDataProperties.swift
//  Finart
//
//  Created by Suren Kazaryan on 13.05.2022.
//
//

import Foundation
import CoreData


extension TransactionCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TransactionCD> {
        return NSFetchRequest<TransactionCD>(entityName: "TransactionCD")
    }

    @NSManaged public var count: Int64
    @NSManaged public var secondCount: Int64
    @NSManaged public var date: Date?
    @NSManaged public var id: Int64
    @NSManaged public var identificator: UUID
    @NSManaged public var name: String?
    @NSManaged public var accountDestination: AccountCD?
    @NSManaged public var accountTransaction: AccountCD?
    @NSManaged public var incomeTransaction: IncomeCD?
    @NSManaged public var spendingTransaction: SpendingCD?

}

extension TransactionCD : Identifiable {

}
