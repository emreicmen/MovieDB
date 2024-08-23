//
//  TvShowsViewController.swift
//  MovieDBTraining3
//
//  Created by Emre İÇMEN on 26.06.2024.
//

import UIKit

class TvShowsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private var apiModel = ApiService()
    private var viewModel = TvShowViewModel()
    
    let layout = UICollectionViewFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        layout.scrollDirection = .vertical
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UINib(nibName: "TvShowCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MainIdentifier")
        view.addSubview(collectionView)

        self.loadAiringTodayShows()
        self.loadOnAirTvShows()
        self.loadPopularTvShows()
        self.loadDiscoveredShows()
        
    }
    
    private func loadPopularTvShows(){
        viewModel.fetchPopularTvShows { [weak self] in
            self?.collectionView.reloadData()
        }
    }  
    
    private func loadOnAirTvShows(){
        viewModel.fetchOnTheAirTvShows{ [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    private func loadAiringTodayShows(){
        viewModel.fetchAiringToday{ [weak self] in
            self?.collectionView.reloadData()
        }
    } 
    
    private func loadDiscoveredShows(){
        viewModel.fetchDiscoveredTvShows{ [weak self] in
            self?.collectionView.reloadData()
        }
    }

}

extension TvShowsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, TvShowCollectionViewCellDelegate {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return TvShowsSections.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainIdentifier", for: indexPath) as! TvShowCollectionViewCell
        cell.testLoad(popularTvShows: viewModel.cellForRowAt(at: indexPath), sectionType: viewModel.getSectionTypeName(indexPath), delegate: self)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: UIScreen.main.bounds.width, height: 200.0)
    }
    
    func didTapMovie(tvShows: TvShows?) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "DetailsViewController") as? DetailsViewController
        viewController?.isTvShow = true
        viewController?.selectedTvShows = tvShows
        self.navigationController?.pushViewController(viewController!, animated: true)
    }
}
