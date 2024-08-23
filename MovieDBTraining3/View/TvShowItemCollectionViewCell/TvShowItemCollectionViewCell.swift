//
//  TvShowItemCollectionViewCell.swift
//  MovieDBTraining3
//
//  Created by Emre İÇMEN on 26.06.2024.
//

import UIKit
import Kingfisher
import Alamofire

class TvShowItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var tvShowItemImageView: UIImageView!
    @IBOutlet weak var releaseDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()


    }

    func setCellWithValues(_ popularTvShows: TvShows) {
        
        if let imageUrl = popularTvShows.posterPath,
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(imageUrl)") {
            
            DispatchQueue.main.async {
                self.tvShowItemImageView.kf.setImage(with: url)
            }
            //getImage(url: url)
        }
        
        releaseDate.text = popularTvShows.firstAirDate
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
                    self.tvShowItemImageView.image = image
                }
            }
        }.resume()
    }
}
