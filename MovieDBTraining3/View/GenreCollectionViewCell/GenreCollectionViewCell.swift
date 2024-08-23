//
//  GenreCollectionViewCell.swift
//  MovieDBTraining3
//
//  Created by Emre İÇMEN on 2.07.2024.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var genreNameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
 
    }
    
    func setCellWithValues(_ genre: Genre) {
        genreNameLbl.text = genre.name
    }
}

