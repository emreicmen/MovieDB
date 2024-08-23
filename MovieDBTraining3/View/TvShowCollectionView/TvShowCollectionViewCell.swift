//
//  TvShowCollectionViewCell.swift
//  MovieDBTraining3
//
//  Created by Emre İÇMEN on 26.06.2024.
//

import UIKit

protocol TvShowCollectionViewCellDelegate {
    
    func didTapMovie(tvShows: TvShows?)

}

class TvShowCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tvSectionTextLabel: UILabel!
    
    private var popularTvShows: [TvShows] = []
    private var delegate: TvShowCollectionViewCellDelegate?
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: UIScreen.main.bounds.width / 4, height: 175.0)
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        collectionView.delegate = self
        
        collectionView.register(UINib(nibName: "TvShowItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TvShowItemCollectionViewCell")
        
        collectionView.dataSource = self
    }
    
    func testLoad(popularTvShows: [TvShows],sectionType: String, delegate: TvShowCollectionViewCellDelegate?) {
        self.popularTvShows = popularTvShows
        collectionView.reloadData()
        tvSectionTextLabel.text = sectionType
        self.delegate = delegate
    }

}

extension TvShowCollectionViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return popularTvShows.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TvShowItemCollectionViewCell", for: indexPath) as! TvShowItemCollectionViewCell
        cell.setCellWithValues(popularTvShows[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didTapMovie(tvShows: popularTvShows[indexPath.item])
        print("\(indexPath.item)")
    }

}
