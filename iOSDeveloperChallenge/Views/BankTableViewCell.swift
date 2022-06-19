//
//  BankTableViewCell.swift
//  iOSDeveloperChallenge
//
//  Created by Muhammed Emin Aydın on 17.06.2022.
//

import Foundation
import UIKit

class BankTableViewCell: UITableViewCell {
    
    static let identifier = "BankTableViewCell"
    
    var model : CellViewModel? {
        didSet {
            guard let model = model else { return }
            idLabel.text = String(model.id)
            subeLabel.text = model.sube.isEmpty ? "Bulunamadi" : model.sube
        }
    }
    
    private let idLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let subeLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(idLabel)
        contentView.addSubview(subeLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        idLabel.frame = CGRect(x: 15, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.height)
        subeLabel.frame = CGRect(x: 60, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.height)

    }
    

    
}
