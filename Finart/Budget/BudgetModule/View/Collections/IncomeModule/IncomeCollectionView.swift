//
//  IncomeCollectionView.swift
//  Finart
//
//  Created by Suren Kazaryan on 15.04.2022.
//

import UIKit

//MARK: - CellDelegate
extension IncomeCollectionView: CellDelegate {
    func delete(cell: IncomeCollectionViewCell) {
        if let indexPath = indexPath(for: cell) {
            budgetViewDelegate?.deleteCell(cellType: .income, row: indexPath.row)
            incomeViewModels.remove(at: indexPath.item)
            deleteItems(at: [indexPath])
        }
    }
    
}

class IncomeCollectionView: UICollectionView {
    var budgetViewDelegate: BudgetViewDelegate?
    let customCellId = "custumCell"
    let layout = UICollectionViewFlowLayout()
    let itemsPerRow: CGFloat = 4
    let sectionInserts = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    var incomeViewModels: [IncomeViewModel] = []
    var incomeSourceRow: Int?
    var isMoved = false
    
    init() {
        super.init(frame: .zero, collectionViewLayout: layout)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Private methods
extension IncomeCollectionView {
    private func setup() {
        layout.scrollDirection = .horizontal
        backgroundColor = .systemBackground

        
        clipsToBounds = true
        layer.cornerRadius = 20
        //layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        //layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        translatesAutoresizingMaskIntoConstraints = false
        register(IncomeCollectionViewCell.self, forCellWithReuseIdentifier: customCellId)
        register(AddCell.self, forCellWithReuseIdentifier: "AddCell")
        dataSource = self
        delegate = self
        isEditing = false
        showsHorizontalScrollIndicator = false

        addInteraction(UIDragInteraction(delegate: self))
        
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
//        let lp = UILongPressGestureRecognizer(target: self, action: #selector(longPress2))
//        lp.minimumPressDuration = 1
//        lp.cancelsTouchesInView = false
//        lp.name = "editMode"
//        addGestureRecognizer(lp)
        //MARK: - Don t touch!
    }
    
    private func itemHeght() -> CGFloat {
        var itemHeght: CGFloat
        let paddingHeight = sectionInserts.top + sectionInserts.bottom
        itemHeght = frame.height - paddingHeight
        return itemHeght
    }
    
    private func spacing() -> CGFloat {
        let spacing: CGFloat
        let availabaleWidth = frame.width - (itemHeght() * itemsPerRow)
        spacing = availabaleWidth / (itemsPerRow + 1)
        return spacing
    }
    
    @objc private func longPress2(longPress: UILongPressGestureRecognizer) {
        isEditing = true
        self.reloadData()
    }
    
    
}

//MARK: - UICollectionViewDataSource
extension IncomeCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return incomeViewModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == incomeViewModels.count - 1 && indexPath.section == 0 && isEditing == false {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddCell", for: indexPath) as? AddCell else { return UICollectionViewCell() }
            cell.updateImage(image: incomeViewModels[indexPath.row].icon)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: customCellId, for: indexPath) as? IncomeCollectionViewCell else { return UICollectionViewCell() }
            
            cell.imageView.alpha = 1
            cell.update(name: incomeViewModels[indexPath.row].name,
                        account: incomeViewModels[indexPath.row].count,
                        planAccount: incomeViewModels[indexPath.row].planCount,
                        image: incomeViewModels[indexPath.row].icon,
                        currency: incomeViewModels[indexPath.row].currency)
            
            if isEditing {
                cell.imageView.alpha = 1
                cell.shake()
            } else {
                cell.stopShaking()
            }
            
            cell.delegate = self
            return cell
        }
    }
    
}

//MARK: - UICollectionViewDelegateFlowLayout
extension IncomeCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let heightPerItem = itemHeght()
        let widthPerItem = heightPerItem
        
        return CGSize(width: widthPerItem, height: heightPerItem)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: sectionInserts.top, left: spacing(), bottom: sectionInserts.bottom, right: spacing())
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spacing()
    }

}


//MARK: - UICollectionViewDelegate
extension IncomeCollectionView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        budgetViewDelegate?.moveCell(cellType: .income, source: sourceIndexPath.row, destination: destinationIndexPath.row)

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == incomeViewModels.count - 1 {
            budgetViewDelegate?.addCell(cellType: .income)
        } else {
            budgetViewDelegate?.select(cellType: .income, row: indexPath.row)
        }
    }
    
}



//MARK: - UIDragInteractionDelegate
extension IncomeCollectionView: UIDragInteractionDelegate {
    func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        if isEditing == false {
            let touchedPoint = session.location(in: self)
            let indexByTouch = indexPathForItem(at: touchedPoint)
            if indexByTouch?.row != incomeViewModels.count - 1 {
                if let touchedImageView = self.hitTest(touchedPoint, with: nil) as? UIImageView {
                    let touchedImage = touchedImageView.image
                    let imageProvider = NSItemProvider(object: touchedImage!)
                    let dragItem = UIDragItem(itemProvider: imageProvider)
                    dragItem.localObject = touchedImageView
                    
                    let itemIndexPath = indexPathForItem(at: touchedPoint)
                    incomeSourceRow = itemIndexPath?.row
                    
                    return [dragItem]
                }
            }
        } else if isEditing == true {
            let touchedPoint = session.location(in: self)
            if let touchedImageView = self.hitTest(touchedPoint, with: nil) as? UIImageView {
                let touchedImage = touchedImageView.image
                let imageProvider = NSItemProvider(object: touchedImage!)
                let dragItem = UIDragItem(itemProvider: imageProvider)
                dragItem.localObject = touchedImageView
                return [dragItem]
            }
        }
        return []
    }
    
    func dragInteraction(_ interaction: UIDragInteraction, previewForLifting item: UIDragItem, session: UIDragSession) -> UITargetedDragPreview? {
        if isEditing == false {
            if let imageView = item.localObject as? UIImageView {
                return UITargetedDragPreview(view: imageView)
            }
        }
        return nil
        
    }
    
    func dragInteraction(_ interaction: UIDragInteraction, willAnimateLiftWith animator: UIDragAnimating, session: UIDragSession) {
        if isEditing == false {
            session.items.forEach { dragItem in
                if let touchedImageView = dragItem.localObject as? UIImageView {
                    animator.addAnimations {
                        touchedImageView.alpha = 1
                    }
                    if isEditing == false {
                        animator.addCompletion { position in
                            if self.isEditing == false {
                                if self.isMoved {
                                    touchedImageView.alpha = 0
                                }
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    func dragInteraction(_ interaction: UIDragInteraction, previewForCancelling item: UIDragItem, withDefault defaultPreview: UITargetedDragPreview) -> UITargetedDragPreview? {
        if isEditing == false {
            let view = item.localObject as! UIView
            let targetDragPreview = UITargetedDragPreview(view: view)
            return targetDragPreview
        }
        return nil
    }
    
    
    func dragInteraction(_ interaction: UIDragInteraction, item: UIDragItem, willAnimateCancelWith animator: UIDragAnimating) {
        if isEditing == false {
            let touchedImageView = item.localObject as! UIView
            if isEditing == false {
                animator.addAnimations {
                    touchedImageView.alpha = 0
                }
            }
            animator.addCompletion { position in
                touchedImageView.alpha = 1
            }
        }
    }
    
    func dragInteraction(_ interaction: UIDragInteraction, session: UIDragSession, didEndWith operation: UIDropOperation) {
        //print("income end")
        isMoved = false
        session.items.forEach { dragItem in
            if let touchedImageView = dragItem.localObject as? UIImageView {
                    touchedImageView.alpha = 1
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
    
    func dragInteraction(_ interaction: UIDragInteraction, sessionDidTransferItems session: UIDragSession) {
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
    
}
