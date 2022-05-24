//
//  AccountCollectionView.swift
//  Finart
//
//  Created by Suren Kazaryan on 15.04.2022.
//

import UIKit

protocol AccountCellDelegate {
    func delete(cell: AccountCollectionViewCell)
}

//MARK: - CellDelegate
extension AccountCollectionView: AccountCellDelegate {
    func delete(cell: AccountCollectionViewCell) {
        if let indexPath = indexPath(for: cell) {
            budgetViewDelegate?.deleteCell(cellType: .account, row: indexPath.row)
            accountArray.remove(at: indexPath.item)
            deleteItems(at: [indexPath])
        }
    }

}

class AccountCollectionView: UICollectionView {
    let customCellId = "accountCell"
    let itemsPerRow: CGFloat = 3
    let sectionInserts = UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)
    let layout = UICollectionViewFlowLayout()
    //var addTransaction: ((Int?)->(Void))?
    var accountSourceRow: Int?
    var accountDestinationRow: Int?
    var accountArray: [AccountViewModel] = []
    var budgetViewDelegate: BudgetViewDelegate?
    var isMoved: Bool = false
    var isAccountTransfer: Bool = false
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "trash"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.frame = CGRect(x: 100, y: 0, width: 200, height: 200)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    init() {
        super.init(frame: .zero, collectionViewLayout: layout)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
}

//MARK: - Private methods
extension AccountCollectionView {
    private func setup() {
        layout.scrollDirection = .horizontal
        backgroundColor = .systemBackground
        layer.cornerRadius = 20
        
        translatesAutoresizingMaskIntoConstraints = false
        register(AccountCollectionViewCell.self, forCellWithReuseIdentifier: customCellId)
        register(AddCell.self, forCellWithReuseIdentifier: "AddCell")
        dataSource = self
        delegate = self
        isEditing = false
        showsHorizontalScrollIndicator = false
        
        addInteraction(UIDragInteraction(delegate: self))
        addInteraction(UIDropInteraction(delegate: self))
        
        isUserInteractionEnabled = true
        
        gestureRecognizers?.forEach { (recognizer) in
            if let longPressRecognizer = recognizer as? UILongPressGestureRecognizer {
                if longPressRecognizer.name == "bandSelectionInitiationPress" {
                } else if longPressRecognizer.name == "dragInitiation" {
                    longPressRecognizer.minimumPressDuration = 0.07
                }
            }
        }
        
        //MARK: - Don t touch!
//        let lp = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
//        lp.minimumPressDuration = 1
//        lp.cancelsTouchesInView = false
//        lp.name = "editMode"
//        addGestureRecognizer(lp)
        //MARK: - Don t touch!

    }
    
    private func giveItemWidth() -> CGFloat {
        let itemWidth: CGFloat
        let paddingWidth = sectionInserts.left * (itemsPerRow + 1)
        let availabaleWidth = frame.width - paddingWidth
        itemWidth = availabaleWidth / itemsPerRow
        return itemWidth
    }
    
    @objc private func longPress(longPress: UILongPressGestureRecognizer) {
        isEditing = true
        self.reloadData()
    }
    
}

//MARK: - UICollectionViewDataSource
extension AccountCollectionView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return accountArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == accountArray.count - 1 && indexPath.section == 0 && isEditing == false {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddCell", for: indexPath) as? AddCell else { return UICollectionViewCell() }
            cell.updateImage(image: accountArray[indexPath.row].icon)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: customCellId, for: indexPath) as? AccountCollectionViewCell else { return UICollectionViewCell() }
            cell.update(name: accountArray[indexPath.row].name, count: accountArray[indexPath.row].count, image: accountArray[indexPath.row].icon, currency: accountArray[indexPath.row].currency)
            
            if isEditing {
                //cell.imageView.alpha = 1
                cell.shake()
            } else {
                cell.stopShaking()
            }
            
            cell.accountCellDelegate = self
            
            return cell
        }
    }

}

//MARK: - UICollectionViewDelegateFlowLayout
extension AccountCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthPerItem = giveItemWidth()//availabaleWidth / itemsPerRow
        let paddingHeght = sectionInserts.top + sectionInserts.bottom
        let heghtPerItem = collectionView.frame.height - paddingHeght

        return CGSize(width: widthPerItem, height: heghtPerItem)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInserts
    }

}

//MARK: - UICollectionViewDelegate
extension AccountCollectionView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        budgetViewDelegate?.moveCell(cellType: .account, source: sourceIndexPath.row, destination: destinationIndexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == accountArray.count - 1 {
            budgetViewDelegate?.addCell(cellType: .account)
        } else {
            budgetViewDelegate?.select(cellType: .account, row: indexPath.row)
        }
    }
    
}

//MARK: - UIDragInteractionDelegate
extension AccountCollectionView: UIDragInteractionDelegate {
    func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
  //      print("itemsForBeginning")
        if isEditing == false {
            let touchedPoint = session.location(in: self)
            if let index = indexPathForItem(at: touchedPoint) {
                if index.row != accountArray.count - 1 {
                    let image = accountArray[index.row].icon
                    let itemProvider = NSItemProvider(object: image)
                    let dragItem = UIDragItem(itemProvider: itemProvider)
                    
                    let iv = UIImageView()
                    iv.contentMode = .scaleAspectFit
                    addSubview(iv)
                    iv.image = image
                    iv.layer.cornerRadius = 12
                    
                    var cellPoints: CGPoint = CGPoint(x: 0, y: 0)
                    if let indexPath = indexPathForItem(at: touchedPoint) {
                        let cell = cellForItem(at: indexPath)
                        cellPoints.x = cell?.frame.minX ?? 0
                        cellPoints.y = cell?.frame.minY ?? 0
                    }
                    let previewWidth = giveItemWidth() / 2
                    iv.frame = CGRect(x: touchedPoint.x - previewWidth/2, y: touchedPoint.y - previewWidth/2, width: previewWidth, height: previewWidth)
                    dragItem.localObject = iv
                    accountSourceRow = index.row
                    return [dragItem]
                }
            }
        } else if isEditing == true {
            let imageProvider = NSItemProvider(object: "asd" as NSString)
            let dragItem = UIDragItem(itemProvider: imageProvider)
            dragItem.localObject = imageView
            return [dragItem]
        }
        return []
    }
    
    func dragInteraction(_ interaction: UIDragInteraction, previewForLifting item: UIDragItem, session: UIDragSession) -> UITargetedDragPreview? {
     //   print("previewForLifting")
        if isEditing == false {
            let touchedPoint = session.location(in: self)
            if let view = item.localObject as? UIImageView {
                if let indexPath = indexPathForItem(at: touchedPoint) {
                    let cell = cellForItem(at: indexPath)
                    cell?.alpha = 0
                }
                
                return UITargetedDragPreview(view: view)
            }
        }
        return nil
    }
    
    func dragInteraction(_ interaction: UIDragInteraction, prefersFullSizePreviewsFor session: UIDragSession) -> Bool {
        return false
    }
    
    func dragInteraction(_ interaction: UIDragInteraction, willAnimateLiftWith animator: UIDragAnimating, session: UIDragSession) {
      //  print("willAnimateLiftWith")
        if isEditing == false {
            session.items.forEach { item in
                if let view = item.localObject as? UIImageView {
                    animator.addCompletion { position in
                        if self.isEditing == false {
                            if self.isMoved {
                                view.alpha = 0
                            } else if self.isMoved == false {
                                view.removeFromSuperview()
                                guard let accountSourceRow = self.accountSourceRow else { return }
                                let cell = self.cellForItem(at: IndexPath(row: accountSourceRow, section: 0))
                                cell?.alpha = 1
                                //view.alpha = 0
                           //     print("ooops222")
                            }
                        }
                    }
                }
            }
            
        }
        
    }
    
    func dragInteraction(_ interaction: UIDragInteraction, previewForCancelling item: UIDragItem, withDefault defaultPreview: UITargetedDragPreview) -> UITargetedDragPreview? {
   //     print("previewForCancelling")
        if isEditing == false {
            if let view = item.localObject as? UIImageView {
                let targetDragPreview = UITargetedDragPreview(view: view)
                view.alpha = 0
                //view.removeFromSuperview()
                return targetDragPreview
            }
        }
        return nil
    }
    
    
    func dragInteraction(_ interaction: UIDragInteraction, item: UIDragItem, willAnimateCancelWith animator: UIDragAnimating) {
      //  print("willAnimateCancelWith")
        animator.addCompletion { UIViewAnimatingPosition in
            let cell = self.cellForItem(at: IndexPath(row: self.accountSourceRow ?? 0, section: 0))
            if let view = item.localObject as? UIImageView {
                cell?.alpha = 1
                //view.removeFromSuperview()
            }
            
        }
        
    }
    
    func dragInteraction(_ interaction: UIDragInteraction, session: UIDragSession, didEndWith operation: UIDropOperation) {
        accountSourceRow = nil
        accountDestinationRow = nil
        isMoved = false
        session.items.forEach { dragItem in
            if let touchedImageView = dragItem.localObject as? UIImageView {
                    touchedImageView.removeFromSuperview()
            }
        }
        endInteractiveMovement()
    }
    
    func dragInteraction(_ interaction: UIDragInteraction, session: UIDragSession, willEndWith operation: UIDropOperation) {
        session.items.forEach { dragItem in
            if let touchedImageView = dragItem.localObject as? UIImageView {
                    touchedImageView.alpha = 1
            }
        }
    }
    
    
    func dragInteraction(_ interaction: UIDragInteraction, sessionDidMove session: UIDragSession) {
        if isEditing {
            updateInteractiveMovementTargetPosition(session.location(in: self))
        }
    }
    
    func dragInteraction(_ interaction: UIDragInteraction, sessionWillBegin session: UIDragSession) {
        if isEditing {
            guard let targetIndexPath = indexPathForItem(at: session.location(in: self)) else { return }
            beginInteractiveMovementForItem(at: targetIndexPath)
        }
        isMoved = true
    }
    
    func dragInteraction(_ interaction: UIDragInteraction, sessionDidTransferItems session: UIDragSession) {
    }
    
}

//MARK: - UIDropInteractionDelegate
extension AccountCollectionView: UIDropInteractionDelegate {
    
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: UIImage.self)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        let itemIndexPath = indexPathForItem(at: session.location(in: self))
        accountDestinationRow = itemIndexPath?.row
        return UIDropProposal(operation: .cancel)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidEnd session: UIDropSession) {
        //addTransaction?(accountDestination)
        if let accountDestinationRow = accountDestinationRow {
            if accountDestinationRow == accountArray.count - 1 || accountDestinationRow == accountSourceRow {
                accountSourceRow = nil
                print("a")
                return
            }
        }
            
        if accountSourceRow != nil && accountSourceRow != nil && isAccountTransfer {
         //   print("account -> account")
            guard let destinationRow = accountDestinationRow else { return }
            budgetViewDelegate?.transaction(fromCellType: .account, destinationRow: destinationRow)
            
       //     accountSourceRow = nil
        } else if accountSourceRow == nil {
           // print("income -> account")
            guard let destinationRow = accountDestinationRow else { return }
            budgetViewDelegate?.transaction(fromCellType: .income, destinationRow: destinationRow)
         //   accountSourceRow = nil
        }
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidExit session: UIDropSession) {
        isAccountTransfer = false
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidEnter session: UIDropSession) {
        isAccountTransfer = true
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
    }
    
}
