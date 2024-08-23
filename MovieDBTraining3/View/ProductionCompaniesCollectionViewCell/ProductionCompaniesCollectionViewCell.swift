//
//  ProductionCountriesCollectionViewCell.swift
//  MovieDBTraining3
//
//  Created by Emre İÇMEN on 2.07.2024.
//

import UIKit
import Kingfisher
import Alamofire

class ProductionCompaniesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var productionCompanyNameLabel: UILabel!
    @IBOutlet weak var productionCompanyImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    
    func setCellWithValues(_ productionCompanies: ProductionCompany) {
        
        if let imageUrl = productionCompanies.logoPath,
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(imageUrl)") {
            
            DispatchQueue.main.async {
                self.productionCompanyImage.kf.setImage(with: url)
            }

            //getImage(url: url)
        }
        productionCompanyNameLabel.text = productionCompanies.name
        
    }
        
    func getImage(url: URL) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print("DetaTask error: \(error.localizedDescription)")
            }
            guard response is HTTPURLResponse else {
                print("Empty response")
                return
            }
            guard let data = data else {
                print("Empty data")
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data){
                    self.productionCompanyImage.image = image
                }
            }
        }.resume()
    }
}
