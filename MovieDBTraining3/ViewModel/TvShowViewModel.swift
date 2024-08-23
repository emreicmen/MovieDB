//
//  TvShowViewModel.swift
//  MovieDBTraining3
//
//  Created by Emre İÇMEN on 26.06.2024.
//

import Foundation


enum TvShowsSections: String, CaseIterable {
    
    case airingTodayTvShowsList = "Airing Today"
    case onTheAirTvShowsList = "On The Air"
    case popularTvShowsList = "Populer"
    case topRatedTvShowsList = "Top Rated"
    case discoveredTvShowsList = "Discover"
}

class TvShowViewModel {
    
    private var apiService = ApiService()
    
    private var popularTvShowsList: [TvShows] = []
    private var topRatedTvShowsList: [TvShows] = []
    private var onTheAirTvShowsList: [TvShows] = []
    private var airingTodayTvShowsList: [TvShows] = []
    private var discoveredTvShowsList: [TvShows] = []
    private var similarTvShowsList: [TvShows] = []
    private var recommenedTvShowsList: [TvShows] = []
    private var tvShowDetailsList: [TvShowDetailsModel] = []
    
    //İç içe istek var
    func fetchPopularTvShows(completion: @escaping() -> ()) {
        
        apiService.getPopularTvShows{ [weak self] result in
            
            switch result {
            case .success(let listOf):
                self?.popularTvShowsList = listOf.results ?? []
                self?.fetchTopRatedTvShows(completion: { items in
                    self?.topRatedTvShowsList = items
                    completion()
                })
            case .failure(let error):
                print("Error processing\(#function)json data: \(error.localizedDescription)")
            }
        }
    }

    func fetchSimilarTvShows(completion: @escaping([TvShows]) -> (), tvShowId: Int) {
        
        apiService.getSimilarTvShows(completion: { [weak self] result in
            switch result {
            case .success(let listOf):
                self?.similarTvShowsList = listOf.results ?? []
                completion(listOf.results ?? [])
                
            case .failure(let error):
                print("Error processing\(#function)json data: \(error.localizedDescription)")
            }
        }, tvShowId: tvShowId)
    }
    

    func fetchRecommenedTvShows(completion: @escaping([TvShows]) -> (), tvShowId: Int) {
        
        apiService.getRecommenedTvShows(completion: { [weak self] result in
            switch result {
            case .success(let listOf):
                self?.recommenedTvShowsList = listOf.results ?? []
                completion(listOf.results ?? [])

            case .failure(let error):
                print("Error processing\(#function)json data: \(error.localizedDescription)")
            }
        }, tvShowId: tvShowId)
    }
    
    
    func fetchTopRatedTvShows(completion: @escaping([TvShows]) -> ()) {
        
        apiService.getTopRatedTvShows{ [weak self] result in
            
            switch result {
            case .success(let listOf):
                self?.topRatedTvShowsList = listOf.results ?? []
                completion(listOf.results ?? [])
                
            case .failure(let error):
                completion([])
                print("Error processing\(#function)json data: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchOnTheAirTvShows(completion: @escaping() -> ()) {
        
        apiService.getOnTheAirTvShows{ [weak self] result in
            
            switch result {
            case .success(let listOf):
                self?.onTheAirTvShowsList = listOf.results ?? []
                completion()
                
            case .failure(let error):
                print("Error processing\(#function)json data: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchAiringToday(completion: @escaping() -> ()) {
        
        apiService.getAiringTodayTvShows{ [weak self] result in
            
            switch result {
            case .success(let listOf):
                self?.airingTodayTvShowsList = listOf.results ?? []
                completion()
                
            case .failure(let error):
                print("Error processing\(#function)json data: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchDiscoveredTvShows(completion: @escaping() -> ()) {
        
        apiService.getDiscoverTvShows{ [weak self] result in
            
            switch result {
            case .success(let listOf):
                self?.discoveredTvShowsList = listOf.results ?? []
                completion()
                
            case .failure(let error):
                print("Error processing\(#function)json data: \(error.localizedDescription)")
            }
        }
    }
        
    func fetchTvShowDetails(completion: @escaping(TvShowDetailsModel) -> (), tvShowId: Int) {
        
        apiService.getTvShowDetails(completion: { [weak self] result in
            switch result {
            case .success(let listOf):
                self?.tvShowDetailsList = [listOf]
                completion(listOf)
                
            case .failure(let error):
                print("Error processing\(#function)json data: \(error.localizedDescription)")
            }
        }, tvShowId: tvShowId)
    }
    
    func numberOfItemsInSection(section: Int) -> Int {
        
        switch section {
        case 0:
            return airingTodayTvShowsList.count
        case 1:
            return onTheAirTvShowsList.count
        case 2:
            return topRatedTvShowsList.count
        case 3:
            return discoveredTvShowsList.count
        case 4:
            return popularTvShowsList.count
        default:
            return popularTvShowsList.count
        }
    }
    
    func cellForRowAt(at indexPath: IndexPath) -> [TvShows] {
        
        switch indexPath.section {
        case 0:
            return airingTodayTvShowsList
        case 1:
            return onTheAirTvShowsList
        case 2:
            return popularTvShowsList
        case 3:
            return discoveredTvShowsList
        case 4:
            return topRatedTvShowsList
        default:
            return popularTvShowsList
        }
    }

    func getSectionTypeName(_ indexPath: IndexPath) -> String {
        switch indexPath.section {
        case 0:
            return TvShowsSections.airingTodayTvShowsList.rawValue
        case 1:
            return TvShowsSections.onTheAirTvShowsList.rawValue
        case 2:
            return TvShowsSections.popularTvShowsList.rawValue
        case 3:
            return TvShowsSections.discoveredTvShowsList.rawValue
        case 4:
            return TvShowsSections.topRatedTvShowsList.rawValue
        default:
            return TvShowsSections.popularTvShowsList.rawValue
        }
    }
}
