//
//  TypeColorCell.swift
//  intermine-ios
//
//  Created by Nadia on 7/21/17.
//  Copyright © 2017 Nadia. All rights reserved.
//

import UIKit

class TypeColorCell: UITableViewCell {
    
    private enum CategoryType: String {
        case Gene = "Gene"
        case Protein = "Protein"
        case Publication = "Publication"
        case Organism = "Organism"
        case Interaction = "Interaction"
        case GO = "GO"
        case Nuffink = "Nuffink"
    }
    
    
    func getSideColor(categoryType: String?) -> UIColor {
        var color = Colors.silver
        if let title = categoryType {
            switch title {
            case CategoryType.Gene.rawValue:
                color = Colors.sushi
                break
            case CategoryType.Protein.rawValue:
                color = Colors.amber
                break
            case CategoryType.Publication.rawValue:
                color = Colors.dodgerBlue
                break
            case CategoryType.Organism.rawValue:
                color = Colors.amaranth
                break
            case CategoryType.Interaction.rawValue:
                color = Colors.orange
                break
            case CategoryType.GO.rawValue:
                color = Colors.seance
                break
            default:
                break
            }
        }
        return color
    }

}
