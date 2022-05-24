//
//  DataPickerCell.swift
//  Finart
//
//  Created by Suren Kazaryan on 02.05.2022.
//

import Foundation
import UIKit

class DataPickerViewCell: UITableViewCell {
    var delegate: ReportDayDelegate?
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "circle")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines = 1
        label.text = "Name"
        return label
    }()
    
    lazy var countLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 14)
        label.numberOfLines = 1
        label.text = "1000"
        return label
    }()
    
    lazy var dataPicker: UIDatePicker = {
        let dataPicker = UIDatePicker()
        dataPicker.translatesAutoresizingMaskIntoConstraints = false
        dataPicker.datePickerMode = .date
        dataPicker.timeZone = .current
        dataPicker.addTarget(self, action: #selector(datePicked), for: .valueChanged)
        return dataPicker
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Private methods
extension DataPickerViewCell {
    private func setup() {
        backgroundColor = .systemBackground
                
        contentView.addSubviews(views: [
            iconImageView,
            nameLabel,
            dataPicker
            //countLabel,
        ])
                
        NSLayoutConstraint.activate([
            
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8),
            iconImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8),
        
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            dataPicker.topAnchor.constraint(equalTo: contentView.topAnchor),
            dataPicker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            dataPicker.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
        ])
    }
    
    @objc private func datePicked(sender: UIDatePicker) {
        var date = sender.date
     //   date.addTimeInterval(60*60*3) // УЖАСНО
        
        delegate?.changeReportDay(date: date)
    }
    
}
