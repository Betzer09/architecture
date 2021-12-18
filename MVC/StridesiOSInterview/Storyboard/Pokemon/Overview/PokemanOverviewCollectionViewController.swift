//
//  PokemanOverviewCollectionView.swift
//  StridesiOSInterview
//
//  Created by Austin Betzer on 4/27/21.
//

import Foundation
import UIKit

class PokemanOverviewCollectionViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private var pokemanCollectionView: UICollectionView!
    
    // MARK: - Properties
    private var pokemans: [PokemanDetails]? {
        didSet {
            reloadView()
        }
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        loadPokeman()
    }
    
    // MARK: - View Overrides
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetails", let des = segue.destination as? PokemanDetailsViewController {
            des.pokeman = sender as? PokemanDetails
        }
    }
    
    // MARK: - Actions
    
    // MARK: - Public methods
    
    // MARK: - Private methods
    private func loadPokeman() {
        APIManager.loadAllPokeman { [weak self] (result) in
            switch result {
            case .failure(let e):
                DispatchQueue.main.async {
                    guard let self = self else {return}
                    UIUtils.showSimpleActionAlert(vc: self, title: "Ooops", message: "We were unable to load the pokeman list, please try again.")
                }
                print("$$$ Failed to load results: \(e.localizedDescription)")
            case .success(let pokemans):
                guard let self = self else {return}
                self.pokemans = pokemans
            }
        }
    }
    
    
    // MARK: - UI Setup
    private func setupCollectionView() {
        pokemanCollectionView.register(UINib(nibName: PokemanCollectionViewCell.cellIdentifer, bundle: nil), forCellWithReuseIdentifier: PokemanCollectionViewCell.cellIdentifer)
    }
    
    private func reloadView() {
        DispatchQueue.main.async {
            self.pokemanCollectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDelegate
extension PokemanOverviewCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pokeman = pokemans?[indexPath.row]
        performSegue(withIdentifier: "toDetails", sender: pokeman)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension PokemanOverviewCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width / 3) - 5
        let height = collectionView.frame.height / 5
        return CGSize(width: width, height: height)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 5)
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

// MARK: - UICollectionViewDataSource
extension PokemanOverviewCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemans?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemanCollectionViewCell.cellIdentifer, for: indexPath) as? PokemanCollectionViewCell else {return UICollectionViewCell()}
        cell.pokeman = pokemans?[indexPath.row]
        return cell
    }
    
}
