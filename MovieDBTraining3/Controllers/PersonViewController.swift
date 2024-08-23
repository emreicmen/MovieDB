//
//  PersonViewController.swift
//  MovieDBTraining3
//
//  Created by Emre İÇMEN on 28.06.2024.
//

import UIKit



class PersonViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private var viewModel = PersonViewModel()
    
    var selectedPerson: Person?
    
    let layout = UICollectionViewFlowLayout()

    private var delegate: MovieCollectonViewCellDelegate?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        
        layout.itemSize = .init(width: UIScreen.main.bounds.width / 2 - 10, height: 300.0)
        collectionView.collectionViewLayout = layout
        collectionView.register(UINib(nibName: "PersonCollectionViewCell", bundle: nil),forCellWithReuseIdentifier: "MainIdentifier")
        view.addSubview(collectionView)

        viewModel.fetchPersonData { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

extension PersonViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainIdentifier", for: indexPath) as! PersonCollectionViewCell
        let person = viewModel.cellForRowAt(at: indexPath)
        cell.setCellWithValues(person)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        didTapMovie(person: viewModel.didSelectItem(at: indexPath))
    }
    
    
    func didTapMovie(person: Person?) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "PersonDetailViewController") as? PersonDetailViewController
        viewController?.chosenPerson = person
        self.navigationController?.pushViewController(viewController!, animated: true)
    }
}
