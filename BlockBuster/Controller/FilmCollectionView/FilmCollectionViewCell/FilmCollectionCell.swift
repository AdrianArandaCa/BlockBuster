//
//  FilmCollectionCell.swift
//  BlockBuster
//
//  Created by Adrian Aranda Campanario on 31/7/24.
//

import UIKit

class FilmCollectionCell: UICollectionViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
//    @IBOutlet weak var titleLabel: UILabel!
    var film: FilmModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setStyle()
    }
    
    func setStyle() {
//        titleLabel.numberOfLines = 2
//        titleLabel.font = UIFont.systemFont(ofSize: 12)
//        titleLabel.textAlignment = .center
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.clipsToBounds = true
        posterImageView.layer.cornerRadius = 8.0
    }
    
    func fillData() {
        guard let film = self.film else { return }
//        titleLabel.text = film.title
        posterImageView.image = film.image
    }
    
    func configure(film: FilmModel) {
        self.film = film
        fillData()
    }

}
