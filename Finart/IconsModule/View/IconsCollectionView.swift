//
//  IconsViewController.swift
//  Finart
//
//  Created by Suren Kazaryan on 23.04.2022.
//

import UIKit

struct Icons {
    let name: String
    let icons: [String]
}

class IconsCollectionView: UICollectionView {
    let customCellId = "custumCell"
    let itemsPerRow: CGFloat = 5
    let sectionInserts = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
//    let iconsArray: [String] = [
//        //Money
//        IconLib.banknote.rawValue,
//        IconLib.creditCard.rawValue,
//        IconLib.cart.rawValue,
//        IconLib.bag.rawValue,
//
//        //Transport
//        IconLib.car.rawValue,
//        IconLib.boltCar.rawValue,
//        IconLib.bus.rawValue,
//        IconLib.tram.rawValue,
//        IconLib.tramTunel.rawValue,
//        IconLib.bicycle.rawValue
//
//
//    ]
    
    let iconsArray: [String] = IconLib.allCases.map { $0.rawValue }
    var iconCallback: ((String) -> ())?
    
    
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
extension IconsCollectionView {
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .secondarySystemBackground
        register(IconsCollectionViewCell.self, forCellWithReuseIdentifier: customCellId)
        dataSource = self
        delegate = self
    }
    
    private func giveItemWidth() -> CGFloat {
        let itemWidth: CGFloat
        let paddingWidth = sectionInserts.left * (itemsPerRow + 1)
        let availabaleWidth = frame.width - paddingWidth
        itemWidth = availabaleWidth / itemsPerRow
        return itemWidth
    }
    
    private func giveVerticalSpacing() -> CGFloat {
        let verticalSpacing: CGFloat
        let verticalItemCount = floor(frame.height / giveItemWidth())
        let availabaleHeght = frame.height - (giveItemWidth() * verticalItemCount)
        verticalSpacing = availabaleHeght / (verticalItemCount + 1)
        return verticalSpacing
    }
    
    
}

//MARK: - UICollectionViewDataSource
extension IconsCollectionView: UICollectionViewDataSource {

//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
//                                                                     withReuseIdentifier: "c",
//                                                                     for: indexPath) as UICollectionReusableView
//        return header
//    }
//
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return iconsArray.count//iconsArray[section].icons.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: customCellId, for: indexPath) as? IconsCollectionViewCell else { return UICollectionViewCell() }
        if let image = UIImage(systemName: iconsArray[indexPath.row]) {//UIImage(systemName: iconsArray[indexPath.section].icons[indexPath.row]) {//iconsArray[indexPath.row]) {
            cell.putImage(image: image)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let icomName = iconsArray[indexPath.row]
        iconCallback?(icomName)
        print(icomName)
    }

}

//MARK: - UICollectionViewDelegateFlowLayout
extension IconsCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthPerItem = giveItemWidth()

        return CGSize(width: widthPerItem, height: widthPerItem)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: giveVerticalSpacing(), left: 8, bottom: giveVerticalSpacing(), right: 8)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return giveVerticalSpacing()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }

}


//MARK: - UICollectionViewDelegate
extension IconsCollectionView: UICollectionViewDelegate {
}
