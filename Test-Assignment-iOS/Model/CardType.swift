//
//  CardType.swift
//  Test-Assignment-iOS
//
//  Created by cr3w on 16.05.2021.
//

import Foundation

/*
  all visa card number starting with 4, master card with 5
*/

enum CardType: String {
    case Visa, MasterCard
    
}

extension CardType {
    
    init?(number start: Character?) {
        switch start {
        case "4":
            self = CardType.Visa
        case "5":
            self = CardType.MasterCard
        default:
            return nil
        }
    }
}
