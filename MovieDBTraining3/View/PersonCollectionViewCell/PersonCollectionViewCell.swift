//
//  PersonCollectionViewCell.swift
//  MovieDBTraining3
//
//  Created by Emre İÇMEN on 28.06.2024.
//

import UIKit
import Kingfisher
import Alamofire

class PersonCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var personImageView: UIImageView!
    @IBOutlet weak var personNameLabel: UILabel!
    
    private var delegate: PersonCollectionViewCell?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func setCellWithValues(_ popularPerson: Person) {
        
        if let imageUrl = popularPerson.profilePath,
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(imageUrl)") {
            
            DispatchQueue.main.async {
                self.personImageView.kf.setImage(with: url)
            }
            
            //getImage(url: url)
        }
        personNameLabel.text = popularPerson.originalName
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
                    self.personImageView.image = image
                }
            }
        }.resume()
    }
}
