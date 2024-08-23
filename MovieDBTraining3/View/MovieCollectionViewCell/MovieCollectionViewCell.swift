//
//  MovieCollectionViewCell.swift
//  MovieDBTraining3
//
//  Created by Emre İÇMEN on 13.06.2024.
//

import UIKit

protocol MovieCollectonViewCellDelegate: AnyObject {
    
    func didTapMovie(movie: Movies?)
    
}

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var movieSectionTitleLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var popularMovies: [Movies] = []
    private var delegate: MovieCollectonViewCellDelegate?
    
    override func awakeFromNib() {
        
        super.awakeFromNib()

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: UIScreen.main.bounds.width / 4, height: 175.0)
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        collectionView.delegate = self

        collectionView.register(UINib(nibName: "MovieItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieItemCollectionViewCell")
        
        collectionView.dataSource = self
    }

    func testLoad(popularMovies: [Movies], sectionTypeName: String, delegate: MovieCollectonViewCellDelegate?) {
        self.popularMovies = popularMovies
        collectionView.reloadData()
        movieSectionTitleLabel.text = sectionTypeName
        self.delegate = delegate
        
    }

}

extension MovieCollectionViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return popularMovies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieItemCollectionViewCell", for: indexPath) as! MovieItemCollectionViewCell
        cell.setCellWithValues(popularMovies[indexPath.item])
        return cell
    }
    //Delegate için burada çaırmamız gerekli
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didTapMovie(movie: popularMovies[indexPath.item])
        print(indexPath.item)
    }
    
}
