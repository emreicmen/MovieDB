//
//  DetailsViewController.swift
//  MovieDBTraining3
//
//  Created by Emre İÇMEN on 11.06.2024.
//

import UIKit

class DetailsViewController: UIViewController {
    
    //MARK: Declerations
    @IBOutlet weak var detailMovieTitle: UILabel!
    @IBOutlet weak var detailTagLine: UILabel!
    @IBOutlet weak var detailOriginalTitile: UILabel!
    @IBOutlet weak var detailContentNetworkImageView: UIImageView!
    @IBOutlet weak var detailContentNetworkName: UILabel!
    @IBOutlet weak var detailPosterImage: UIImageView!
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailStatus: UILabel!
    @IBOutlet weak var detailContentDate: UILabel!
    @IBOutlet weak var detailContentHomePage: UILabel!

    @IBOutlet weak var contentStatInfos: UIStackView!
    @IBOutlet weak var detailRuntime: UILabel!
    @IBOutlet weak var deatilsPopularity: UILabel!
    @IBOutlet weak var detailBudget: UILabel!
    @IBOutlet weak var detailsVoteCount: UILabel!
    @IBOutlet weak var detailRevenue: UILabel!
    @IBOutlet weak var detailVoteAverage: UILabel!
    @IBOutlet weak var detailIncome: UILabel!
    @IBOutlet weak var detailContentOriginCountry: UILabel!

    @IBOutlet weak var genreStackView: UIStackView!
    @IBOutlet weak var genreCollectionView: UICollectionView!

    @IBOutlet weak var detailOverviewLabel: UILabel!

    @IBOutlet weak var productionCountriesStackView: UIStackView!
    @IBOutlet weak var productionCountiresCollectionView: UICollectionView!

    @IBOutlet weak var productionCompaniesStackView: UIStackView!
    @IBOutlet weak var productionCompaniesCollectionView: UICollectionView!

    @IBOutlet weak var similarContentStackView: UIStackView!
    @IBOutlet weak var similarContentTitleLabel: UILabel!
    @IBOutlet weak var similarContentCollectionView: UICollectionView!
    
    @IBOutlet weak var recommenedContentStackView: UIStackView!
    @IBOutlet weak var recommenedContentKind: UILabel!
    @IBOutlet weak var recommenedContentCollectionView: UICollectionView!
    
    
    var selectedMovie: Movies?
    var selectedTvShows: TvShows?
    
    var movieDetail: MovieDetailsModel?
    var tvShowDetail: TvShowDetailsModel?
    
    var similarMoviesList: [Movies]? = []
    var similarTvShowList: [TvShows]? = []
    
    var recommenedMoviesList: [Movies]? = []
    var recommenedTvShowsList: [TvShows]? = []

    var similarContentId: Int = 0
    var isSimilarContent: Bool = false
    
    private var apiModel = ApiService()
    private var movieViewModel = MovieViewModel()
    private var tvShowViewModel = TvShowViewModel()
    
    let layout = UICollectionViewFlowLayout()

    var isTvShow: Bool = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCollectionViewStuff()
                
        if isTvShow == true {
            similarContentTitleLabel.text = "Similar Tv Shows"
            recommenedContentKind.text = "Recommened Tv Shows"
            loadTvShowDetails()
            loadSimilarTvShows()
            loadRecommenedTvShows()

        }else {
            similarContentTitleLabel.text = "Similar Movies"
            recommenedContentKind.text = "Recommened Movies"
            loadMovieDetails()
            loadSimilarMovies()
            loadRecommenedMovies()
        }
        
        let contentHomepageGesture = UITapGestureRecognizer(target: self, action: #selector(self.goToContentHomepage))
        detailContentHomePage.isUserInteractionEnabled = true
        detailContentHomePage.addGestureRecognizer(contentHomepageGesture)
                
        print(isSimilarContent)
        
    }

    
    private func loadSimilarMovies() {
        
        movieViewModel.fetchSimilarMovies(completion: { [weak self] similarMovie in
            self?.similarMoviesList = similarMovie
            self?.recommenedContentCollectionView.reloadData()
            self?.similarContentCollectionView.reloadData()
            self?.genreCollectionView.reloadData()
            self?.productionCompaniesCollectionView.reloadData()
            self?.productionCountiresCollectionView.reloadData()
        }, movieId: selectedMovie?.id ?? 0)
    }
    
   //MARK: Similar Tv Shows
    private func loadSimilarTvShows() {
        
        tvShowViewModel.fetchSimilarTvShows(completion: { [weak self] similarTvShows in
            self?.similarTvShowList = similarTvShows
            self?.recommenedContentCollectionView.reloadData()
            self?.similarContentCollectionView.reloadData()
            self?.genreCollectionView.reloadData()
            self?.productionCompaniesCollectionView.reloadData()
            self?.productionCountiresCollectionView.reloadData()
        }, tvShowId: selectedTvShows?.id ?? 0)
    }
    

    //MARK: RecommenedMovies
    private func loadRecommenedMovies() {

        movieViewModel.fetchRecommenedMovies(completion: { [weak self] recommenedMovies in
            self?.recommenedMoviesList = recommenedMovies
            self?.recommenedContentCollectionView.reloadData()
            self?.similarContentCollectionView.reloadData()
            self?.genreCollectionView.reloadData()
            self?.productionCompaniesCollectionView.reloadData()
            self?.productionCountiresCollectionView.reloadData()
        }, movieId: selectedMovie?.id ?? 0)
    }
    
    
    //MARK: RecommenedMovies
    private func loadRecommenedTvShows() {

        tvShowViewModel.fetchRecommenedTvShows(completion: { [weak self] recommenedTvShows in
            self?.recommenedTvShowsList = recommenedTvShows
            self?.recommenedContentCollectionView.reloadData()
            self?.similarContentCollectionView.reloadData()
            self?.genreCollectionView.reloadData()
            self?.productionCompaniesCollectionView.reloadData()
            self?.productionCountiresCollectionView.reloadData()
        }, tvShowId: selectedTvShows?.id ?? 0)
    }

    //MARK: Movie Details
    private func loadMovieDetails() {
        
        movieViewModel.fetchMovieDetails(completion: { [weak self] tvShowDetails in
            print(self?.selectedMovie?.id ?? 0)
            self?.movieDetail = tvShowDetails
            
            self?.detailContentNetworkName.isEnabled = false
            self?.detailContentNetworkName.isHidden = true
            self?.detailContentNetworkImageView.isHidden = true
            
            self?.detailContentOriginCountry.text = "Origin Country:\(tvShowDetails.originCountry?[0] ?? "No Info")"
            self?.detailContentHomePage.text = tvShowDetails.homepage
            self?.detailOverviewLabel.text = tvShowDetails.overview
            self?.detailVoteAverage.text = "Vote: \(String(tvShowDetails.voteCount ?? 0))"
            self?.detailVoteAverage.text = "Vote Average: \(String(tvShowDetails.voteAverage ?? 0))"
            self?.detailContentDate.text = "Release Date:\(tvShowDetails.releaseDate ?? "")"
            
            self?.detailRuntime.text = "Runtime:\(String(tvShowDetails.runtime ?? 0)) min"
            self?.detailTagLine.text = tvShowDetails.tagline
            
            //Original Title status
            if self?.selectedMovie?.originalTitle == tvShowDetails.title {
                self?.detailMovieTitle.text = tvShowDetails.title
                self?.detailOriginalTitile.text = ""
            }else {
                self?.detailMovieTitle.text = tvShowDetails.title
                self?.detailOriginalTitile.text = tvShowDetails.originalTitle
            }
            
            //Movie status (Release-Delayed)
            if tvShowDetails.status == "Released" {
                self?.detailStatus.backgroundColor = UIColor.green
                self?.detailStatus.text = tvShowDetails.status
            }else {
                self?.detailStatus.backgroundColor = UIColor.yellow
                self?.detailStatus.text = tvShowDetails.status
            }
            
            //Revenue check
            if tvShowDetails.revenue ?? 0  < 1000 {
                self?.detailRevenue.text = "No Revenue Info"
                self?.detailIncome.text = "No Total Income Info"
            }else {
                let revenue = tvShowDetails.revenue
                self?.detailRevenue.text = "Revenue:\(self?.formatNumberWithSeparator(number: revenue ?? 0) ?? "")$"
            }
            
            //Budget check
            if tvShowDetails.budget ?? 0 < 1000 {
                self?.detailBudget.text = "No Budget Info"
                self?.detailIncome.text = "No Total Income Info"

            }else {
                let budget = tvShowDetails.budget
                self?.detailBudget.text = "Budget:\(self?.formatNumberWithSeparator(number: budget ?? 0) ?? "")$"
            }
            
            //İncome check
            if tvShowDetails.revenue ?? 0 > 1000 && tvShowDetails.budget! > 1000 {
                let income = tvShowDetails.revenue! - tvShowDetails.budget!
                self?.detailIncome.text = "Total Income:\(self?.formatNumberWithSeparator(number: income) ?? "")$"
                self?.detailIncome.textColor = UIColor.systemGreen
                if income <= 0 {
                    self?.detailIncome.text = "Total Income:\(self?.formatNumberWithSeparator(number: income) ?? "")$"
                    self?.detailIncome.textColor = UIColor.red
                }
            }
                
             guard let backDropImageUrl = URL(string: "https://image.tmdb.org/t/p/w500\(tvShowDetails.backdropPath ?? "")") else {
                 self?.detailImageView.image = UIImage(named: "doc")
                 return
             }
             guard let posterImageUrl = URL(string: "https://image.tmdb.org/t/p/w500\(tvShowDetails.posterPath ?? "")") else {
                 self?.detailPosterImage.image = UIImage(named: "doc")
                 return
             }

            self?.getBackDropImageData(url: backDropImageUrl)
             self?.getPosterImageData(url: posterImageUrl)
        }, movieId: selectedMovie?.id ?? 0)
    }
    
    //MARK: TVShow Details
    private func loadTvShowDetails() {
                        
        tvShowViewModel.fetchTvShowDetails(completion: { [weak self] detailObject in
            
            print(self?.selectedTvShows?.id ?? 0)
            self?.tvShowDetail = detailObject

            self?.detailContentOriginCountry.text = "Origin Country:\(detailObject.originCountry?[0] ?? "No Info")"
            self?.detailOverviewLabel.text = detailObject.overview
            self?.detailVoteAverage.text = "Vote: \(String(detailObject.voteCount ?? 0))"
            self?.detailVoteAverage.text = "Vote Average: \(String(detailObject.voteAverage ?? 0))"
            self?.detailContentDate.text = "First Air Date:\(detailObject.firstAirDate ?? "")"
            self?.detailMovieTitle.text = detailObject.name
            self?.detailContentHomePage.text = detailObject.homepage
            self?.detailContentNetworkName.text = detailObject.networks?[0].name
            self?.detailTagLine.text = detailObject.tagline
            self?.detailRuntime.text = "Number Of Season: \(String(detailObject.numberOfSeasons ?? 0))"
            self?.detailBudget.text = "Number Of Episodes: \(String(detailObject.numberOfEpisodes ?? 0))"
            self?.detailRevenue.text = "Last Episode: \(detailObject.lastAirDate ?? "No Info")"
            self?.detailIncome.isHidden = true
            
            //Original Title status
            if self?.selectedMovie?.originalTitle == detailObject.name {
                self?.detailMovieTitle.text = detailObject.name
                self?.detailOriginalTitile.text = ""
            }else {
                self?.detailMovieTitle.text = detailObject.name
                self?.detailOriginalTitile.text = detailObject.originalName
                
            }
            
            //Production Status
            if detailObject.status != "Ended" {
                self?.detailStatus.text = detailObject.status
                self?.detailStatus.backgroundColor = UIColor.systemGreen
            }else{
                self?.detailStatus.text = detailObject.status
                self?.detailStatus.backgroundColor = UIColor.red
            }
                
            guard let backDropImageUrl = URL(string: "https://image.tmdb.org/t/p/w500\(detailObject.backdropPath ?? "")") else {
                self?.detailImageView.image = UIImage(named: "doc")
                return
            }
            guard let posterImageUrl = URL(string: "https://image.tmdb.org/t/p/w500\(detailObject.posterPath ?? "")") else {
                self?.detailPosterImage.image = UIImage(named: "doc")
                return
            }
            guard let networkImageUrl = URL(string: "https://image.tmdb.org/t/p/w500\(detailObject.networks?[0].logoPath ?? "")") else {
                self?.detailPosterImage.image = UIImage(named: "doc")
                return
            }
                    
            self?.getBackDropImageData(url: backDropImageUrl)
            self?.getPosterImageData(url: posterImageUrl)
            self?.getNetworkImageData(url: networkImageUrl)
            
        }, tvShowId: selectedTvShows?.id ?? 0)
        
    }
        
    private func loadCollectionViewStuff() {
        
        [similarContentCollectionView,genreCollectionView, productionCompaniesCollectionView, productionCountiresCollectionView,recommenedContentCollectionView].forEach {
            $0?.dataSource = self
            $0?.delegate = self
        }

        genreCollectionView.register(UINib(nibName: "GenreCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MainIndetifier")
//        view.addSubview(genreCollectionView)

        productionCompaniesCollectionView.register(UINib(nibName: "ProductionCompaniesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductionCompaniesSubCell")
//        view.addSubview(productionCompaniesCollectionView)
        
        productionCountiresCollectionView.register(UINib(nibName: "ProductionCountriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductionCountriesCollectionSubCell")
//        view.addSubview(productionCountiresCollectionView)
        
        similarContentCollectionView.register(UINib(nibName: "SimilarContentCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SimilarContentCollectionSubCell")
//        view.addSubview(similarContentCollectionView)
        
        recommenedContentCollectionView.register(UINib(nibName: "RecommenedContentCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RecommenedContentSubCell")
//        view.addSubview(similarContentCollectionView)
        
    }
    
    private func formatNumberWithSeparator(number: Int) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = "."
        return numberFormatter.string(from: NSNumber(value: number))
    }

    private func getPosterImageData(url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("DataTask Error: \(error.localizedDescription)")
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
                    self.detailPosterImage.image = image
                }
            }
        }.resume()
    }
    
    private func getBackDropImageData(url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("DataTask Error: \(error.localizedDescription)")
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
                    self.detailImageView.image = image
                }
            }
        }.resume()
    }
    
    private func getNetworkImageData(url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("DataTask Error: \(error.localizedDescription)")
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
                    self.detailContentNetworkImageView.image = image
                }
            }
        }.resume()
    }
    
    @objc func goToContentHomepage() {
        if isTvShow == true {
            if let url = URL(string: String(tvShowDetail?.homepage ?? "")) {
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
             }
        }else {
            if let url = URL(string: String(movieDetail?.homepage ?? "")) {
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
             }
        }
    }
    
}

extension DetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == genreCollectionView {
            if self.isTvShow {
                return tvShowDetail?.genres?.count ?? 0
            } else {
                return movieDetail?.genres?.count ?? 0
            }
        }
        else if collectionView == productionCountiresCollectionView {
            if self.isTvShow {
                return tvShowDetail?.productionCountries?.count ?? 0
            } else {
                return movieDetail?.productionCountries?.count ?? 0
            }
        }
        else if collectionView == similarContentCollectionView {
            if self.isTvShow {
                return similarTvShowList?.count ?? 0
            } else {
                return similarMoviesList?.count ?? 0
            }
        }
        else if collectionView == recommenedContentCollectionView {
            if self.isTvShow {
                return recommenedTvShowsList?.count ?? 0
            } else {
                return recommenedMoviesList?.count ?? 0
            }
        }
        else {
            if self.isTvShow {
                return tvShowDetail?.productionCompanies?.count ?? 0
            } else {
                return movieDetail?.productionCompanies?.count ?? 0
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == genreCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainIndetifier", for: indexPath) as! GenreCollectionViewCell
            
            if self.isTvShow, let item = tvShowDetail?.genres?[indexPath.item] {
                cell.setCellWithValues(item)
            } else if let item = movieDetail?.genres?[indexPath.item] {
                cell.setCellWithValues(item)
            }
            return cell
        }

        else if collectionView == productionCompaniesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductionCompaniesSubCell", for: indexPath) as! ProductionCompaniesCollectionViewCell
            
            if self.isTvShow, let item = tvShowDetail?.productionCompanies?[indexPath.item] {
                cell.setCellWithValues(item)
            } else if let item = movieDetail?.productionCompanies?[indexPath.item] {
                cell.setCellWithValues(item)
            }
            return cell
        }
        
        else if collectionView == similarContentCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SimilarContentCollectionSubCell", for: indexPath) as! SimilarContentCollectionViewCell
            
            if self.isTvShow, let item = similarTvShowList?[indexPath.item] {
                cell.setCellWithSimilarTvShows(item)
            } else if let item = similarMoviesList?[indexPath.item] {
                cell.setCellWithSimilarMovies(item)
            }
            return cell
        }
        
        
        else if collectionView == recommenedContentCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommenedContentSubCell", for: indexPath) as! RecommenedContentCollectionViewCell
            
            if self.isTvShow, let item = recommenedTvShowsList?[indexPath.item] {
                cell.setCellWithRecommenedTvShows(item)
            } else if let item = recommenedMoviesList?[indexPath.item] {
                cell.setCellWithRecommenedMovies(item)
            }
            return cell
        }
        
        else if collectionView == productionCountiresCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductionCountriesCollectionSubCell", for: indexPath) as! ProductionCountriesCollectionViewCell

            if self.isTvShow, let item = tvShowDetail?.productionCountries?[indexPath.item] {
                cell.setCellWithValues(item)
            } else if let item = movieDetail?.productionCountries?[indexPath.item] {
                cell.setCellWithValues(item)
            }
            return cell
        }
        
        else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == similarContentCollectionView {
            isSimilarContent = true
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController
            similarContentId = similarMoviesList?[indexPath.item].id ?? 0
            print(similarContentId)
            self.navigationController?.pushViewController(viewController!, animated: true)

        }
    }
}


