//
//  PersonDetailViewController.swift
//  MovieDBTraining3
//
//  Created by Emre İÇMEN on 3.07.2024.
//

import UIKit
import Kingfisher
import Alamofire

class PersonDetailViewController: UIViewController {

    @IBOutlet weak var personHomepage: UILabel!
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var personName: UILabel!
    @IBOutlet weak var personPopularity: UILabel!
    @IBOutlet weak var personBirthday: UILabel!
    @IBOutlet weak var personBirthPlace: UILabel!
    @IBOutlet weak var personGender: UILabel!
    @IBOutlet weak var personKnownDepartment: UILabel!
    @IBOutlet weak var personDeathday: UILabel!
    @IBOutlet weak var personBiography: UILabel!
    
    
    var chosenPerson: Person?
    
    private var viewModel = PersonViewModel()
    
    var personInfos: PersonDetailModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(chosenPerson?.id ?? 0)

        loadInfos()
        
        guard let personImageUrl = URL(string: "https://image.tmdb.org/t/p/w500\(chosenPerson?.profilePath ?? "")") else {
            self.personImage.image = UIImage(named: "doc")
            return
        }
        
        DispatchQueue.main.async {
            self.personImage.kf.setImage(with: personImageUrl)
        }
        
        //self.getPersonImageData(url: personImageUrl)
        
        let homepageGesture = UITapGestureRecognizer(target: self, action: #selector(goToHomepage))
        personHomepage.isUserInteractionEnabled = true
        personHomepage.addGestureRecognizer(homepageGesture)
    }
    
    
    private func getPersonImageData(url: URL) {
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
                    self.personImage.image = image
                }
            }
        }.resume()
    }
    
    private func loadInfos() {
        
        viewModel.fetchPersonDetails(completion: { [weak self] personDetail in
            
            self?.personInfos = personDetail
            
            self?.personName.text = personDetail.name
            self?.personPopularity.text = "Popularity:\(String(personDetail.popularity ?? 0))"
            self?.personBirthday.text = "Birthday:\(personDetail.birthday ?? "")"
            self?.personBirthPlace.text = "Place to Birth:\(personDetail.placeOfBirth ?? "")"
            self?.personBiography.text = personDetail.biography
            self?.personKnownDepartment.text = personDetail.knownForDepartment
            self?.personHomepage.text = personDetail.homepage
            
            if personDetail.deathday == nil {
                self?.personDeathday.isHidden = true
            }else {
                self?.personDeathday.text = "Deathday:\(personDetail.deathday ?? JSONNull())"
            }
            
            if personDetail.gender == 1 {
                self?.personGender.text = "Female"
            }else if personDetail.gender == 2 {
                self?.personGender.text = "Male"
            }else{
                self?.personGender.text = "Non Binary"
            }
            
        }, personId: chosenPerson?.id ?? 0)
        
    }
    
    @objc func goToHomepage(){
        if let url = URL(string: String(self.personInfos?.homepage ?? "")) {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
         }
    }

}
