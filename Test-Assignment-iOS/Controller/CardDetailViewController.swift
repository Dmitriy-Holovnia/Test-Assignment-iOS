//
//  CardDetailViewController.swift
//  Test-Assignment-iOS
//
//  Created by cr3w on 16.05.2021.
//

import UIKit

final class CardDetailViewController: UIViewController {
    
    var card: Card? {
        didSet { configureVC() }
    }
    
    private lazy var cardBackgroundView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var cardLogoView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var bankLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Bank"
        label.textColor = .white
        return label
    }()
    
    private lazy var cardNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureVC() {
        guard let card = card else { return }
        
        cardNumberLabel.text = "**** " + "\(card.number)".suffix(4)
        
        switch card.type {
        case .Visa:
            cardBackgroundView.backgroundColor = UIColor.visaColor
            cardLogoView.image = UIImage(named: "visa-icon")
        case .MasterCard:
            cardBackgroundView.backgroundColor = UIColor.masterCardColor
            cardLogoView.image = UIImage(named: "mastercard-icon")
        }
    }
    
    func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(cardBackgroundView)
        view.addSubview(cardLogoView)
        view.addSubview(cardNumberLabel)
        view.addSubview(bankLabel)
        
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            cardBackgroundView.leadingAnchor.constraint(equalTo: safeLayout.leadingAnchor, constant: 10),
            cardBackgroundView.trailingAnchor.constraint(equalTo: safeLayout.trailingAnchor, constant: -10),
            cardBackgroundView.centerYAnchor.constraint(equalTo: safeLayout.centerYAnchor),
            cardBackgroundView.heightAnchor.constraint(equalTo: safeLayout.widthAnchor, multiplier: 0.62),
            
            cardNumberLabel.leadingAnchor.constraint(equalTo: cardBackgroundView.leadingAnchor, constant: padding),
            cardNumberLabel.topAnchor.constraint(equalTo: cardBackgroundView.centerYAnchor, constant: padding),
            
            cardLogoView.trailingAnchor.constraint(equalTo: cardBackgroundView.trailingAnchor, constant: -padding),
            cardLogoView.centerYAnchor.constraint(equalTo: cardNumberLabel.centerYAnchor),
            cardLogoView.heightAnchor.constraint(equalToConstant: 40),
            cardLogoView.widthAnchor.constraint(equalToConstant: 40),
            
            bankLabel.leadingAnchor.constraint(equalTo: cardBackgroundView.leadingAnchor, constant: padding),
            bankLabel.bottomAnchor.constraint(equalTo: cardBackgroundView.centerYAnchor, constant: -padding),
        ])
    }

}
