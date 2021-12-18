//
//  PokemanCollectionViewCell.swift
//  StridesiOSInterview
//
//  Created by Austin Betzer on 4/27/21.
//

import UIKit

class PokemanCollectionViewCell: UICollectionViewCell {
    static let cellIdentifer = "PokemanCollectionViewCell"
    
    @IBOutlet private var containerView: UIView!
    @IBOutlet private var pokemanNameLabel: UILabel!
    @IBOutlet private var pokemanCountLabel: UILabel!
    @IBOutlet private var pokemanImageView: CachedImageView!
    
    public var pokeman: PokemanDetails? {
        didSet {
            configureView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 8
    }
    
    private func configureView() {
        guard let pokeman = pokeman else {return}
        self.pokemanNameLabel.text = pokeman.name.capitalized
        self.pokemanCountLabel.text = "#\(pokeman.order)"
        loadImage()
    }
    
    private func loadImage() {
        guard let pokeman = pokeman else {return}
        self.pokemanImageView.loadImageWithUrl(pokeman.sprites.frontDefault) { [weak self] (result) in
            switch result {
            case .failure(let e):
                print("[PokemanCollectionViewCell] failed to load image: \(e.localizedDescription)")
            case .success(let image):
                guard let self = self else {return}
                DispatchQueue.main.async {
                    self.pokemanImageView.image = image
                }
            }
        }
    }
}
