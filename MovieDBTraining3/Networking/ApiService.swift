//
//  ApiModel.swift
//  MovieDBTraining3
//
//  Created by Emre İÇMEN on 11.06.2024.
//

import Foundation

/*
 Movie URL
 https://api.themoviedb.org/3/movie/now_playing?api_key=c6499f37e0c8f222da06a575732cdf73
  
 Movie Detail URL
 https://api.themoviedb.org/3/movie/1022789?api_key=c6499f37e0c8f222da06a575732cdf73
 
 Similar Movies
 https://api.themoviedb.org/3/movie/533535/similar?api_key=c6499f37e0c8f222da06a575732cdf73
 
 Recommendations Movies
 https://api.themoviedb.org/3/movie/1022789/recommendations?api_key=c6499f37e0c8f222da06a575732cdf73
 
 TVShow URL
 https://api.themoviedb.org/3/discover/tv?api_key=c6499f37e0c8f222da06a575732cdf73
 
 Recommendations TVShow
 https://api.themoviedb.org/3/tv/2734/recommendations?api_key=c6499f37e0c8f222da06a575732cdf73
 
 TVShow Detail URL
 https://api.themoviedb.org/3/tv/1022789?api_key=c6499f37e0c8f222da06a575732cdf73
 
 Person URL
 https://api.themoviedb.org/3/person/popular?api_key=c6499f37e0c8f222da06a575732cdf73
 
 Person Detail URL
 https://api.themoviedb.org/3/person/125025?api_key=c6499f37e0c8f222da06a575732cdf73
 
 Image URL
 https://image.tmdb.org/t/p/w500/
 
 
 */


enum EndPoint: String {
    case popular = "popular"
    case nowPlaying = "now_playing"
    case topRated = "top_rated"
    case upComing = "upcoming"
    case airingToday = "airing_today"
    case onTheAir = "on_the_air"
}

private let apiKey = "c6499f37e0c8f222da06a575732cdf73"
private let baseUrlMovie = "https://api.themoviedb.org/3/movie/"
private let baseUrlTvShows = "https://api.themoviedb.org/3/tv/"
private let discoverMovies = "https://api.themoviedb.org/3/discover/movie"
private let discoverTvShows = "https://api.themoviedb.org/3/discover/tv"
private let personPopular = "https://api.themoviedb.org/3/person/popular"

// MARK: Movie URLs
private let requestPopularMovies = "\(baseUrlMovie)\(EndPoint.popular)?api_key=\(apiKey)"
private let requestNowPlayingMovies = "\(baseUrlMovie)\(EndPoint.nowPlaying.rawValue)?api_key=\(apiKey)"
private let requestTopRatedMovies = "\(baseUrlMovie)\(EndPoint.topRated.rawValue)?api_key=\(apiKey)"
private let requestUpComingMovies = "\(baseUrlMovie)\(EndPoint.upComing.rawValue)?api_key=\(apiKey)"
private let requestDiscoverMovies = "\(discoverMovies)?api_key=\(apiKey)"

// MARK: TvShows URLs
private let requestPopularTvShows = "\(baseUrlTvShows)\(EndPoint.popular)?api_key=\(apiKey)"
private let requestTopRatedTvShows = "\(baseUrlTvShows)\(EndPoint.topRated.rawValue)?api_key=\(apiKey)"
private let requestAiringTodayTvShows = "\(baseUrlTvShows)\(EndPoint.airingToday.rawValue)?api_key=\(apiKey)"
private let requestOnTheAirTvShows = "\(baseUrlTvShows)\(EndPoint.onTheAir.rawValue)?api_key=\(apiKey)"
private let requestDiscoverTvShows = "\(discoverTvShows)?api_key=\(apiKey)"


// MARK: Person URL
private let requestPopularPerson = "\(personPopular)?api_key=\(apiKey)"


private var dataTask : URLSessionDataTask?


class ApiService {
    
    //MARK: Movies
    func getPopularMovies(completion: @escaping(Result<MovieModel,Error>) -> Void){
        
        guard let popularMovies = URL(string: requestPopularMovies) else {return}
        
        dataTask = URLSession.shared.dataTask(with: popularMovies, completionHandler: { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                print("DataTask Error: \(error.localizedDescription)")
                return
            }
            
            guard response is HTTPURLResponse else {
                print("Empty response")
                return
            }
            
            guard let data = data else {
                print("Empty data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(MovieModel.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            }catch let error {
                completion(.failure(error))
            }
        })
        dataTask?.resume()
    }
    
    func getNowPlayingMovies(completion: @escaping(Result<MovieModel,Error>) -> Void){
        
        guard let nowPlayingMovies = URL(string: requestNowPlayingMovies) else {return}
        
        dataTask = URLSession.shared.dataTask(with: nowPlayingMovies, completionHandler: { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                print("DataTask Error: \(error.localizedDescription)")
                return
            }
            
            guard response is HTTPURLResponse else {
                print("Empty response")
                return
            }
            
            guard let data = data else {
                print("Empty data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(MovieModel.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            }catch let error {
                completion(.failure(error))
            }
        })
        dataTask?.resume()
    }
    
    func getTopRatedMovies(completion: @escaping(Result<MovieModel,Error>) -> Void){
        
        guard let topRatedMovies = URL(string: requestTopRatedMovies) else {return}
        
        dataTask = URLSession.shared.dataTask(with: topRatedMovies, completionHandler: { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                print("DataTask Error: \(error.localizedDescription)")
                return
            }
            
            guard response is HTTPURLResponse else {
                print("Empty response")
                return
            }
            
            guard let data = data else {
                print("Empty data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(MovieModel.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            }catch let error {
                completion(.failure(error))
            }
        })
        dataTask?.resume()
    }
    
    func getupComingMovies(completion: @escaping(Result<MovieModel,Error>) -> Void){
        
        guard let upComingMovies = URL(string: requestUpComingMovies) else {return}
        
        dataTask = URLSession.shared.dataTask(with: upComingMovies, completionHandler: { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                print("DataTask Error: \(error.localizedDescription)")
                return
            }
            
            guard response is HTTPURLResponse else {
                print("Empty response")
                return
            }
            
            guard let data = data else {
                print("Empty data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(MovieModel.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            }catch let error {
                completion(.failure(error))
            }
        })
        dataTask?.resume()
    }
    
    func getSimilarMovies(completion: @escaping(Result<MovieModel,Error>) -> Void, movieId: Int){
        
        let similarMovie = "https://api.themoviedb.org/3/movie/\(movieId)/similar"
        let requestSimilarMovies = "\(similarMovie)?api_key=\(apiKey)"
        
        guard let similarMovies = URL(string: requestSimilarMovies) else {return}
        
        dataTask = URLSession.shared.dataTask(with: similarMovies, completionHandler: { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                print("DataTask Error: \(error.localizedDescription)")
                return
            }
            
            guard response is HTTPURLResponse else {
                print("Empty response")
                return
            }
            
            guard let data = data else {
                print("Empty data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(MovieModel.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            }catch let error {
                completion(.failure(error))
            }
        })
        dataTask?.resume()
    }
    
    func getRecommenedMovies(completion: @escaping(Result<MovieModel,Error>) -> Void, movieId: Int){
        
        let recommenedMovie = "https://api.themoviedb.org/3/movie/\(movieId)/recommendations"
        let requestRecommenedMovies = "\(recommenedMovie)?api_key=\(apiKey)"
        
        guard let recommenedMovies = URL(string: requestRecommenedMovies) else {return}
        
        dataTask = URLSession.shared.dataTask(with: recommenedMovies, completionHandler: { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                print("DataTask Error: \(error.localizedDescription)")
                return
            }
            
            guard response is HTTPURLResponse else {
                print("Empty response")
                return
            }
            
            guard let data = data else {
                print("Empty data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(MovieModel.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            }catch let error {
                completion(.failure(error))
            }
        })
        dataTask?.resume()
    }
    
    
    
    func getDiscoverMovies(completion: @escaping(Result<MovieModel,Error>) -> Void){
        
        guard let discoverMovies = URL(string: requestDiscoverMovies) else {return}
        
        dataTask = URLSession.shared.dataTask(with: discoverMovies, completionHandler: { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                print("DataTask Error: \(error.localizedDescription)")
                return
            }
            
            guard response is HTTPURLResponse else {
                print("Empty response")
                return
            }
            
            guard let data = data else {
                print("Empty data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(MovieModel.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            }catch let error {
                completion(.failure(error))
            }
        })
        dataTask?.resume()
    }
    
    func getMovieDetails(completion: @escaping(Result<MovieDetailsModel,Error>) -> Void, movieId: Int){
        
        let movieDetails = "https://api.themoviedb.org/3/movie/\(movieId)"
        let requestMovieDetails = "\(movieDetails)?api_key=\(apiKey)"
        
        guard let movieDetails = URL(string: requestMovieDetails) else {return}
        
        dataTask = URLSession.shared.dataTask(with: movieDetails, completionHandler: { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                print("DataTask Error: \(error.localizedDescription)")
                return
            }
            
            guard response is HTTPURLResponse else {
                print("Empty response")
                return
            }
            
            guard let data = data else {
                print("Empty data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(MovieDetailsModel.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            }catch let error {
                completion(.failure(error))
            }
        })
        dataTask?.resume()
    }
    
    //MARK: TvShows
    func getPopularTvShows(completion: @escaping(Result<TvShowModel,Error>) -> Void){
        
        guard let popularTvShows = URL(string: requestPopularTvShows) else {return}
        
        dataTask = URLSession.shared.dataTask(with: popularTvShows, completionHandler: { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                print("DataTask Error: \(error.localizedDescription)")
                return
            }
            
            guard response is HTTPURLResponse else {
                print("Empty response")
                return
            }
            
            guard let data = data else {
                print("Empty data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(TvShowModel.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            }catch let error {
                completion(.failure(error))
            }
        })
        dataTask?.resume()
    }
    
    func getTopRatedTvShows(completion: @escaping(Result<TvShowModel,Error>) -> Void){
        
        guard let topRatedTvShows = URL(string: requestTopRatedTvShows) else {return}
        
        dataTask = URLSession.shared.dataTask(with: topRatedTvShows, completionHandler: { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                print("DataTask Error: \(error.localizedDescription)")
                return
            }
            
            guard response is HTTPURLResponse else {
                print("Empty response")
                return
            }
            
            guard let data = data else {
                print("Empty data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(TvShowModel.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            }catch let error {
                completion(.failure(error))
            }
        })
        dataTask?.resume()
    }
    
    func getOnTheAirTvShows(completion: @escaping(Result<TvShowModel,Error>) -> Void){
        
        guard let onTheAirTvShows = URL(string: requestOnTheAirTvShows) else {return}
        
        dataTask = URLSession.shared.dataTask(with: onTheAirTvShows, completionHandler: { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                print("DataTask Error: \(error.localizedDescription)")
                return
            }
            
            guard response is HTTPURLResponse else {
                print("Empty response")
                return
            }
            
            guard let data = data else {
                print("Empty data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(TvShowModel.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            }catch let error {
                completion(.failure(error))
            }
        })
        dataTask?.resume()
    }
    
    func getAiringTodayTvShows(completion: @escaping(Result<TvShowModel,Error>) -> Void){
        
        guard let airingTodayTvShows = URL(string: requestAiringTodayTvShows) else {return}
        
        dataTask = URLSession.shared.dataTask(with: airingTodayTvShows, completionHandler: { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                print("DataTask Error: \(error.localizedDescription)")
                return
            }
            
            guard response is HTTPURLResponse else {
                print("Empty response")
                return
            }
            
            guard let data = data else {
                print("Empty data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(TvShowModel.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            }catch let error {
                completion(.failure(error))
            }
        })
        dataTask?.resume()
    }
    
    func getDiscoverTvShows(completion: @escaping(Result<TvShowModel,Error>) -> Void){
        
        guard let discoverTvShows = URL(string: requestDiscoverTvShows) else {return}
        
        dataTask = URLSession.shared.dataTask(with: discoverTvShows, completionHandler: { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                print("DataTask Error: \(error.localizedDescription)")
                return
            }
            
            guard response is HTTPURLResponse else {
                print("Empty response")
                return
            }
            
            guard let data = data else {
                print("Empty data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(TvShowModel.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            }catch let error {
                completion(.failure(error))
            }
        })
        dataTask?.resume()
    }
    
    func getTvShowDetails(completion: @escaping(Result<TvShowDetailsModel,Error>) -> Void, tvShowId: Int){
        
        let tvShowDetails = "https://api.themoviedb.org/3/tv/\(tvShowId)"
        let requestTvShowDetails = "\(tvShowDetails)?api_key=\(apiKey)"
        
        guard let tvShowDetails = URL(string: requestTvShowDetails) else {return}
        
        dataTask = URLSession.shared.dataTask(with: tvShowDetails, completionHandler: { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                print("DataTask Error: \(error.localizedDescription)")
                return
            }
            
            guard response is HTTPURLResponse else {
                print("Empty response")
                return
            }
            
            guard let data = data else {
                print("Empty data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(TvShowDetailsModel.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            }catch let error {
                completion(.failure(error))
            }
        })
        dataTask?.resume()
    }
    
    func getRecommenedTvShows(completion: @escaping(Result<TvShowModel,Error>) -> Void, tvShowId: Int){
        
        let recommenedTvShow = "https://api.themoviedb.org/3/tv/\(tvShowId)/recommendations"
        let requestRecommenedTvShows = "\(recommenedTvShow)?api_key=\(apiKey)"
        
        guard let recommenedTvShows = URL(string: requestRecommenedTvShows) else {return}
        
        dataTask = URLSession.shared.dataTask(with: recommenedTvShows, completionHandler: { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                print("DataTask Error: \(error.localizedDescription)")
                return
            }
            
            guard response is HTTPURLResponse else {
                print("Empty response")
                return
            }
            
            guard let data = data else {
                print("Empty data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(TvShowModel.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            }catch let error {
                completion(.failure(error))
            }
        })
        dataTask?.resume()
    }
    
    
    func getSimilarTvShows(completion: @escaping(Result<TvShowModel,Error>) -> Void, tvShowId: Int){
        
        let similarTvShow = "https://api.themoviedb.org/3/tv/\(tvShowId)/similar"
        let requestSimilarTShows = "\(similarTvShow)?api_key=\(apiKey)"
        
        guard let similarTvSHows = URL(string: requestSimilarTShows) else {return}
        
        dataTask = URLSession.shared.dataTask(with: similarTvSHows, completionHandler: { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                print("DataTask Error: \(error.localizedDescription)")
                return
            }
            
            guard response is HTTPURLResponse else {
                print("Empty response")
                return
            }
            
            guard let data = data else {
                print("Empty data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(TvShowModel.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            }catch let error {
                completion(.failure(error))
            }
        })
        dataTask?.resume()
    }
    
    //MARK: Person
    func getPopularPerson(completion: @escaping(Result<PersonModel,Error>) -> Void){
        
        guard let popularPerson = URL(string: requestPopularPerson) else {return}
        
        dataTask = URLSession.shared.dataTask(with: popularPerson, completionHandler: { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                print("DataTask Error: \(error.localizedDescription)")
                return
            }
            
            guard response is HTTPURLResponse else {
                print("Empty response")
                return
            }
            
            guard let data = data else {
                print("Empty data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(PersonModel.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            }catch let error {
                completion(.failure(error))
            }
        })
        dataTask?.resume()
    }
    
    func getPersonDetail(completion: @escaping(Result<PersonDetailModel,Error>) -> Void, personId: Int){
        
        let personDetails = "https://api.themoviedb.org/3/person/\(personId)"
        let requestMovieDetails = "\(personDetails)?api_key=\(apiKey)"
        
        guard let personDetails = URL(string: requestMovieDetails) else {return}
        
        dataTask = URLSession.shared.dataTask(with: personDetails, completionHandler: { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                print("DataTask Error: \(error.localizedDescription)")
                return
            }
            
            guard response is HTTPURLResponse else {
                print("Empty response")
                return
            }
            
            guard let data = data else {
                print("Empty data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(PersonDetailModel.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            }catch let error {
                completion(.failure(error))
            }
        })
        dataTask?.resume()
    }
}

