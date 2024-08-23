//
//  ProductionCountriesCollectionViewCell.swift
//  MovieDBTraining3
//
//  Created by Emre İÇMEN on 3.07.2024.
//

import UIKit

class ProductionCountriesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var countryNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    func setCellWithValues(_ productionCountries: ProductionCountry) {
        countryNameLabel.text = productionCountries.name
    }
}
