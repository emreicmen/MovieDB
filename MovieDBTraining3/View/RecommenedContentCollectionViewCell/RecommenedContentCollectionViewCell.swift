//
//  RecommenedContentCollectionViewCell.swift
//  MovieDBTraining3
//
//  Created by Emre İÇMEN on 8.07.2024.
//

import UIKit
import Kingfisher
import Alamofire

class RecommenedContentCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var contentImage: UIImageView!
    @IBOutlet weak var contentName: UILabel!
    
    
    private var movieViewModel = MovieViewModel()
    private var tvShowViewModel = TvShowViewModel()
    
    var selectedMovie: Movies?
    var selectedTvShows: TvShows?
    
    private var isTvShow = DetailsViewController()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func setCellWithRecommenedMovies(_ movies: Movies) {
        
        if let imageUrl = movies.posterPath,
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(imageUrl)") {
            
            DispatchQueue.main.async {
                self.contentImage.kf.setImage(with: url)
            }

            //self.getImage(url: url)
        }
        
        self.contentName.text = movies.title

        
    }
    
    func setCellWithRecommenedTvShows(_ tvShows: TvShows) {
        
        if let imageUrl = tvShows.posterPath,
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(imageUrl)") {
            
            DispatchQueue.main.async {
                self.contentImage.kf.setImage(with: url)
            }
            
            //self.getImage(url: url)
        }
        
        self.contentName.text = tvShows.name

        
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
                    self.contentImage.image = image
                }
            }
        }.resume()
    }

}


