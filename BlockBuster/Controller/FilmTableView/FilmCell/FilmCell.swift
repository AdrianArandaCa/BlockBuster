//
//  FilmCell.swift
//  BlockBuster
//
//  Created by Adrian Aranda Campanario on 25/7/24.
//

import UIKit

class FilmCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    var film: FilmModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func fillData() {
        guard let film = self.film else { return }
        titleLabel.text = film.title
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(film: FilmModel) {
        self.film = film
        fillData()
    }
}
