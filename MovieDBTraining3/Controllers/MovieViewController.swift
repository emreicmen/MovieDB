//
//  ViewController.swift
//  MovieDBTraining3
//
//  Created by Emre İÇMEN on 11.06.2024.
//

import UIKit

class MovieViewController: UIViewController{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var apiModel = ApiService()
    private var viewModel = MovieViewModel()
    
    var choosenMovie: [Movies]?

    let layout = UICollectionViewFlowLayout()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout.scrollDirection = .vertical
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MainIdentifier")
        view.addSubview(collectionView)
        
        self.loadPopularMovies()
        self.loadNowPlayingMovies()
        self.fetchUpComingMovies()
        self.fetchDiscoveredMovies()

    }
    
    private func loadPopularMovies() {
        viewModel.fetchPopularMovies { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    private func loadNowPlayingMovies() {
        viewModel.fetchNowPlayingMovies { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    private func fetchUpComingMovies() {
        viewModel.fetchUpComingMovies { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    private func fetchDiscoveredMovies() {
        viewModel.fetchDiscoverMovies { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
}

extension MovieViewController: UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return MovieSections.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainIdentifier",for: indexPath) as! MovieCollectionViewCell
        cell.testLoad(popularMovies: viewModel.cellForRowAt(at: indexPath), sectionTypeName: viewModel.getSectionTypeName(indexPath), delegate: self)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: UIScreen.main.bounds.width, height: 200.0)
    }  
    
    
}

//MARK: Delegate
extension MovieViewController: MovieCollectonViewCellDelegate {
    
    //Segue yerine deleagte kullanımı burada yapıldı.
    func didTapMovie(movie: Movies?) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController
        viewController?.isTvShow = false
        viewController?.selectedMovie = movie
        self.navigationController?.pushViewController(viewController!, animated: true)
    }
}
