//
//  PersonViewModel.swift
//  MovieDBTraining3
//
//  Created by Emre İÇMEN on 28.06.2024.
//

import Foundation

class PersonViewModel {
    
    private var apiService = ApiService()
    
    private var personPopularList: [Person] = []
    private var personDetailList: [PersonDetailModel] = []
        
    func fetchPersonData(completion: @escaping() -> ()) {
        
        apiService.getPopularPerson{ [weak self] result in
            
            switch result {
                
            case .success(let listOf):
                self?.personPopularList = listOf.results
                completion()
            case .failure(let error):
                print("Error processing json data: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchPersonDetails(completion: @escaping(PersonDetailModel) -> (), personId: Int) {
        
        apiService.getPersonDetail(completion: { [weak self] result in
            switch result {
            case .success(let listOf):
                self?.personDetailList = [listOf]
                completion(listOf)
                
            case .failure(let error):
                print("Error processing\(#function)json data: \(error.localizedDescription)")
            }
        }, personId: personId)
    }

    
    func numberOfRowsInSection(section: Int) -> Int {
        if personPopularList.count != 0 {
            return personPopularList.count
        }
        return 0
    }
    
    func cellForRowAt(at indexPath: IndexPath) -> Person {
        return personPopularList[indexPath.item]
    }
    
    func didSelectItem(at indexPath: IndexPath) -> Person? {
        return personPopularList[indexPath.item]
    }
}
