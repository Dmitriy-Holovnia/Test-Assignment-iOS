//
//  MainViewController.swift
//  Test-Assignment-iOS
//
//  Created by cr3w on 16.05.2021.
//

import UIKit

final class MainViewController: UITableViewController {
    
    private var allCards = [Card]()
    
    private lazy var addCardButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonTapped))
        return button
    }()
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        getCards()
    }
    
    private func configureUI() {
        title = "Cards"
        
        navigationItem.rightBarButtonItem = addCardButton
        
        tableView.register(CardTableViewCell.self, forCellReuseIdentifier: CardTableViewCell.reuseId)
        tableView.rowHeight = 60
        tableView.separatorStyle = .none
    }
    
    
    private func getCards() {
        PersistentManager.shared.getCards { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let cards):
                DispatchQueue.main.async {
                    self.allCards = cards
                    self.tableView.reloadData()
                }
            case .failure(let error):
                self.showAlert(title: "Loading error", message: error.localizedDescription)
            }
        }
    }
    
    //MARK: Helpers
    private func generateCardNumber() -> Card? {
        var number = ""
        
        let type = [CardType.Visa, CardType.MasterCard].randomElement()
        
        if type == .Visa {
            number += "4"
        } else if type == .MasterCard {
            number += "5"
        }
        for _ in 1...15 {
            let random = Int.random(in: 0...9)
            number += "\(random)"
        }

        guard let cardNumber = Int(number),
              let cardType = type else { return nil }
        
        return Card(number: cardNumber, type: cardType)
    }
    
    //MARK: Selector
    @objc
    private func addButtonTapped() {
        guard let card = generateCardNumber() else { return }
        allCards.insert(card, at: 0)
        
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(item: 0, section: 0)], with: .automatic)
        tableView.endUpdates()

        PersistentManager.shared.createNewCard(card: card) { [weak self] (error) in
            guard let error = error else { return }
            self?.showAlert(title: "Cannot save card", message: error.localizedDescription)
        }
    }
}

//MARK: UITableViewDataSource
extension MainViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCards.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let card = allCards[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: CardTableViewCell.reuseId,
                                                 for: indexPath) as! CardTableViewCell
        cell.configure(with: card)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let card = allCards[indexPath.row]
        let dvc = CardDetailViewController()
        dvc.card = card
        navigationController?.pushViewController(dvc, animated: true)
    }
}
