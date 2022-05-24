//
//  CollectionView.swift
//  Finart
//
//  Created by Suren Kazaryan on 13.04.2022.
//

import UIKit

protocol SpendingCellDelegate {
    func delete(cell: SpendingCollectionViewCell)
}

//MARK: - SpendingCellDelegate
extension SpendingCollectionView: SpendingCellDelegate {
    func delete(cell: SpendingCollectionViewCell) {
        if let indexPath = indexPath(for: cell) {
            budgetViewDelegate?.deleteCell(cellType: .spending, row: indexPath.row)
            spendingArray.remove(at: indexPath.item)
            deleteItems(at: [indexPath])
        }
    }
}

class SpendingCollectionView: UICollectionView {
    let customCellId = "custumCell"
    let itemsPerRow: CGFloat = 4
    let sectionInserts = UIEdgeInsets(top: 8, left: 5, bottom: 8, right: 5)
    var spendingArray: [SpendingViewModel] = []
    var budgetViewDelegate: BudgetViewDelegate?
    var isMoved = false
    var spendingDestinationRow: Int?

    init() {
        let layout = UICollectionViewFlowLayout()
        super.init(frame: .zero, collectionViewLayout: layout)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Private methods
extension SpendingCollectionView {
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        
     //   backgroundColor = .systemBackground
        clipsToBounds = true
        layer.cornerRadius = 20
    //    layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        register(SpendingCollectionViewCell.self, forCellWithReuseIdentifier: customCellId)
        register(AddCell.self, forCellWithReuseIdentifier: "AddCell")
        dataSource = self
        delegate = self
        isEditing = false
        showsVerticalScrollIndicator = false
        isPagingEnabled = true
        
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
        
    }
    
    private func giveItemWidth() -> CGFloat {
        var itemWidth: CGFloat
        let paddingWidth = sectionInserts.left * (itemsPerRow + 1)
        let availabaleWidth = frame.width - paddingWidth
        itemWidth = availabaleWidth / itemsPerRow
        
        var verticalSpacing: CGFloat = 0
        
        while verticalSpacing < 8 && itemWidth > 50 {
            let verticalItemCount = floor(frame.height / itemWidth)
            let availabaleHeght = frame.height - (itemWidth * verticalItemCount)
            verticalSpacing = availabaleHeght / (verticalItemCount + 1)
            if verticalSpacing < 8 && itemWidth > 50 {
                itemWidth -= 0.1
            }
        }
        return itemWidth
    }
    
    private func giveVerticalSpacing() -> CGFloat {
        let verticalItemCount = floor(frame.height / giveItemWidth())
        let availabaleHeght = frame.height - (giveItemWidth() * verticalItemCount)
        let verticalSpacing = availabaleHeght / (verticalItemCount + 1)
        return verticalSpacing
    }
    
    
}

//MARK: - UICollectionViewDataSource
extension SpendingCollectionView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return spendingArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == spendingArray.count - 1 && indexPath.section == 0 && isEditing == false {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddCell", for: indexPath) as? AddCell else { return UICollectionViewCell() }
            cell.updateImage(image: spendingArray[indexPath.row].icon)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: customCellId, for: indexPath) as? SpendingCollectionViewCell else { return UICollectionViewCell() }
            
            cell.update(name: spendingArray[indexPath.row].name,
                        account: spendingArray[indexPath.row].count,
                        planAccount: spendingArray[indexPath.row].planCount,
                        image: spendingArray[indexPath.row].icon,
                        currency: spendingArray[indexPath.row].currency)
            
            if isEditing {
                cell.imageView.alpha = 1
                cell.shake()
            } else {
                cell.stopShaking()
            }
            
            cell.spendingDelegate = self
            return cell
        }
    }

}

//MARK: - UICollectionViewDelegateFlowLayout
extension SpendingCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthPerItem = giveItemWidth()
        return CGSize(width: widthPerItem, height: widthPerItem)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: giveVerticalSpacing(), left: 5, bottom: giveVerticalSpacing(), right: 5)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return giveVerticalSpacing()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }

}

//MARK: - UICollectionViewDelegate
extension SpendingCollectionView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        budgetViewDelegate?.moveCell(cellType: .spending, source: sourceIndexPath.row, destination: destinationIndexPath.row)

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == spendingArray.count - 1 {
            budgetViewDelegate?.addCell(cellType: .spending)
        } else {
            budgetViewDelegate?.select(cellType: .spending, row: indexPath.row)
        }
    }
    
}

//MARK: - UIDragInteractionDelegate
extension SpendingCollectionView: UIDragInteractionDelegate {
    func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        if isEditing == true {
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
    
    func dragInteraction(_ interaction: UIDragInteraction, sessionWillBegin session: UIDragSession) {
        if isEditing {
            guard let targetIndexPath = indexPathForItem(at: session.location(in: self)) else { return }
            beginInteractiveMovementForItem(at: targetIndexPath)
        }
        isMoved = true
    }
    
    func dragInteraction(_ interaction: UIDragInteraction, sessionDidMove session: UIDragSession) {
        if isEditing {
            updateInteractiveMovementTargetPosition(session.location(in: self))
        }
    }
    
    func dragInteraction(_ interaction: UIDragInteraction, session: UIDragSession, didEndWith operation: UIDropOperation) {
        isMoved = false
        session.items.forEach { dragItem in
            if let touchedImageView = dragItem.localObject as? UIImageView {
                    touchedImageView.alpha = 1
            }
        }
        endInteractiveMovement()
    }
    
    func dragInteraction(_ interaction: UIDragInteraction, previewForLifting item: UIDragItem, session: UIDragSession) -> UITargetedDragPreview? {
        return nil
    }
    
}

//MARK: - UIDropInteractionDelegate
extension SpendingCollectionView: UIDropInteractionDelegate {

    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        let itemIndexPath = indexPathForItem(at: session.location(in: self))
        spendingDestinationRow = itemIndexPath?.row
        return UIDropProposal(operation: .cancel)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidEnd session: UIDropSession) {
        guard let destinationRow = spendingDestinationRow else { return }
        if destinationRow != spendingArray.count - 1 {
            budgetViewDelegate?.transaction(fromCellType: .spending, destinationRow: destinationRow)
        }
    }
    
    
}
