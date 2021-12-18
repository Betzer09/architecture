//
//  PokemanDetailsViewController.swift
//  StridesiOSInterview
//
//  Created by Austin Betzer on 4/27/21.
//

import Foundation
import UIKit

class PokemanDetailsViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var pokemanImageView: CachedImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var experienceLabel: UILabel!
    
    // MARK: - Public Properties
    var pokeman: PokemanDetails?
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - View Overrides
    
    // MARK: - Private  methods
    private func setupView() {
        guard let pokeman = pokeman else {return}
        self.title =  "\(pokeman.name.capitalized) Details"
        
        nameLabel.text = "Name: \(pokeman.name.capitalized)"
        weightLabel.text = "Weight: \(pokeman.weight)pds"
        experienceLabel.text = "Experience: \(pokeman.baseExperience)xp"
        
        pokemanImageView.loadImageWithUrl(pokeman.sprites.frontDefault) { [weak self] (result) in
            guard let self = self else {return}
            
            DispatchQueue.main.async {
                switch result {
                case .failure(let e):
                    UIUtils.showSimpleActionAlert(vc: self, title: "Oops!", message: "We were unable to load the image!")
                    print("[PokemanDetailsView] failed to load image: \(e.localizedDescription)")
                case .success(let image):
                    self.pokemanImageView.image = image
                }
            }
            
        }
    }
    
    private func setupLayer() {
        pokemanImageView.layer.shadowColor = UIColor.black.cgColor
        pokemanImageView.layer.shadowOpacity = 0.6
        pokemanImageView.layer.shadowOffset = .zero
        pokemanImageView.layer.shadowRadius = 8
        pokemanImageView.layer.shouldRasterize = true
    }
    
    @IBAction private func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension PokemanDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}

// MARK: - UITableViewDataSource
extension PokemanDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokeman?.orderedMoves.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "moveCell", for: indexPath)
        let pokemanMove = pokeman?.orderedMoves[indexPath.row]
        cell.textLabel?.text = pokemanMove?.move.name
        
        let levelLearned  = pokemanMove?.versionGroupDetails.first?.levelLearnedAt
        let levelLearnedString = levelLearned == nil ? "NA" : "\(levelLearned!)"
        cell.detailTextLabel?.text = "Learned at level \(levelLearnedString)"
        
        return cell
    }
    
    
}
