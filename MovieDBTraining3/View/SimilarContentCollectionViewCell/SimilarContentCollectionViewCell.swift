//
//  SimilarContentCollectionViewCell.swift
//  MovieDBTraining3
//
//  Created by Emre İÇMEN on 5.07.2024.
//

import UIKit
import Kingfisher
import Alamofire

class SimilarContentCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var similarContentName: UILabel!
    @IBOutlet weak var similarContentImage: UIImageView!
    
    private var movieViewModel = MovieViewModel()
    private var tvShowViewModel = TvShowViewModel()
    
    var selectedMovie: Movies?
    var selectedTvShows: TvShows?
    
    private var isTvShow = DetailsViewController()
    
    override func awakeFromNib() {
        super.awakeFromNib()
 

    }
    
    func setCellWithSimilarMovies(_ movies: Movies) {
        
        if let imageUrl = movies.posterPath,
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(imageUrl)") {
            
            DispatchQueue.main.async {
                self.similarContentImage.kf.setImage(with: url)
            }

            //self.getImage(url: url)
        }
        
        self.similarContentName.text = movies.title

        
    }    
    
    func setCellWithSimilarTvShows(_ tvShows: TvShows) {
        
        if let imageUrl = tvShows.posterPath,
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(imageUrl)") {
            self.getImage(url: url)
        }
        
        self.similarContentName.text = tvShows.name

        
    }
    
    private func getImage(url: URL) {
        
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
                    self.similarContentImage.image = image
                }
            }
        }.resume()
    }
}
