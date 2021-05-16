//
//  CardTableViewCell.swift
//  Test-Assignment-iOS
//
//  Created by cr3w on 16.05.2021.
//

import UIKit

class CardTableViewCell: UITableViewCell {
    
    static let reuseId = String(describing: CardTableViewCell.self)
    
    private lazy var numberLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cardImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    func configureUI() {
        
        contentView.addSubview(cardImageView)
        contentView.addSubview(numberLabel)
        
        NSLayoutConstraint.activate([
            cardImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            cardImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cardImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.9),
            cardImageView.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1.8),
            
            numberLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            numberLabel.leadingAnchor.constraint(equalTo: cardImageView.trailingAnchor, constant: 5),
        ])
    }
    
    func configure(with card: Card) {
        let cardSuffix = "\(card.number)".suffix(4)
        numberLabel.text = "**** **** **** " + cardSuffix
        
        switch card.type {
        case .Visa:
            cardImageView.image = UIImage(named: "visa-icon")
        case .MasterCard:
            cardImageView.image = UIImage(named: "mastercard-icon")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
