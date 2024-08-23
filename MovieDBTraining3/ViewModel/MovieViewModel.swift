//
//  MovieViewModel.swift
//  MovieDBTraining3
//
//  Created by Emre İÇMEN on 11.06.2024.
//

import Foundation

enum MovieSections: String, CaseIterable {
    
    case nowPlayingMoviesList = "Now Playing"
    case upComingMoviesList = "Up Coming"
    case popularMoviesList = "Populer"
    case topRatedMoviesList = "Top Rated"
    case discoveredMoviesList = "Discover"
}

class MovieViewModel {
    
    private var apiService = ApiService()
    
    private var popularMoviesList: [Movies] = []
    private var nowPlayingMoviesList: [Movies] = []
    private var topRatedMoviesList: [Movies] = []
    private var upComingMoviesList: [Movies] = []
    private var discoverdMoviesList: [Movies] = []
    private var similarMoviesList: [Movies] = []
    private var recommenedMoviesList: [Movies] = []
    private var movieDetailsList: [MovieDetailsModel] = []
    
    func fetchPopularMovies(completion: @escaping() -> ()) {
        
        apiService.getPopularMovies { [weak self] result in
            
            switch result {
            case .success(let listOf):
                self?.popularMoviesList = listOf.results ?? []
                self?.fetchTopRatedMovies(completion: { items in
                    self?.topRatedMoviesList = items
                    completion()
                })
            case .failure(let error):
                print("Error processing\(#function)json data: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchNowPlayingMovies(completion: @escaping() -> ()) {
        
        apiService.getNowPlayingMovies{ [weak self] result in
            
            switch result {
            case .success(let listOf):
                self?.nowPlayingMoviesList = listOf.results ?? []
                completion()
                
            case .failure(let error):
                print("Error processing\(#function)json data: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchTopRatedMovies(completion: @escaping([Movies]) -> ()) {
        
        apiService.getTopRatedMovies{ [weak self] result in
            
            switch result {
            case .success(let listOf):
//                self?.topRatedMoviesList = listOf.results ?? []
                completion(listOf.results ?? [])
                
            case .failure(let error):
                completion([])
                print("Error processing\(#function)json data: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchUpComingMovies(completion: @escaping() -> ()) {
        
        apiService.getupComingMovies{ [weak self] result in
            
            switch result {
            case .success(let listOf):
                self?.upComingMoviesList = listOf.results ?? []
                completion()
                
            case .failure(let error):
                print("Error processing\(#function)json data: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchSimilarMovies(completion: @escaping([Movies]) -> (), movieId: Int) {
        
        apiService.getSimilarMovies(completion: { [weak self] result in
            switch result {
            case .success(let listOf):
                self?.similarMoviesList = listOf.results ?? []
                completion(listOf.results ?? [])

            case .failure(let error):
                print("Error processing\(#function)json data: \(error.localizedDescription)")
            }
        }, movieId: movieId)
    }
      
    func fetchRecommenedMovies(completion: @escaping([Movies]) -> (), movieId: Int) {
        
        apiService.getRecommenedMovies(completion: { [weak self] result in
            switch result {
            case .success(let listOf):
                self?.recommenedMoviesList = listOf.results ?? []
                completion(listOf.results ?? [])

            case .failure(let error):
                print("Error processing\(#function)json data: \(error.localizedDescription)")
            }
        }, movieId: movieId)
    }
    
    func fetchDiscoverMovies(completion: @escaping() -> ()) {
        
        apiService.getupComingMovies{ [weak self] result in
            
            switch result {
            case .success(let listOf):
                self?.discoverdMoviesList = listOf.results ?? []
                completion()
                
            case .failure(let error):
                print("Error processing\(#function)json data: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchMovieDetails(completion: @escaping(MovieDetailsModel) -> (), movieId: Int) {
        
        apiService.getMovieDetails(completion: { [weak self] result in
            switch result {
            case .success(let listOf):
                self?.movieDetailsList = [listOf]
                completion(listOf)
                
            case .failure(let error):
                print("Error processing\(#function)json data: \(error.localizedDescription)")
            }
        }, movieId: movieId)
    }
    

    
    func numberOfItemsInSection(section: Int) -> Int {
        
        switch section {
        case 0:
            return nowPlayingMoviesList.count
        case 1:
            return upComingMoviesList.count
        case 2:
            return popularMoviesList.count 
        case 3:
            return discoverdMoviesList.count
        case 4:
            return topRatedMoviesList.count
        default:
            return popularMoviesList.count
        }
    }
    
    func cellForRowAt(at indexPath: IndexPath) -> [Movies] {
        
        switch indexPath.section {
        case 0:
            return nowPlayingMoviesList
        case 1:
            return upComingMoviesList
        case 2:
            return popularMoviesList 
        case 3:
            return discoverdMoviesList
        case 4:
            return topRatedMoviesList
        default:
            return popularMoviesList
        }
    }

    func getSectionTypeName(_ indexPath: IndexPath) -> String {
        switch indexPath.section {
        case 0:
            return MovieSections.nowPlayingMoviesList.rawValue
        case 1:
            return MovieSections.upComingMoviesList.rawValue
        case 2:
            return MovieSections.popularMoviesList.rawValue
        case 3:
            return MovieSections.discoveredMoviesList.rawValue
        case 4:
            return MovieSections.topRatedMoviesList.rawValue
        default:
            return MovieSections.popularMoviesList.rawValue
        }
    }
}
