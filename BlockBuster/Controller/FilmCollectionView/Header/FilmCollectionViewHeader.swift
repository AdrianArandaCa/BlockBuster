//
//  FilmCollectionViewHeader.swift
//  BlockBuster
//
//  Created by Adrian Aranda Campanario on 31/7/24.
//

import UIKit

class FilmCollectionViewHeader: UICollectionReusableView {
    @IBOutlet weak var titleLabel: UILabel!
    var kindList: FilmKindList?
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func fillData() {
        titleLabel.text = kindList == .popular ? "POPULAR".localizable : "SEARCH".localizable
    }
    
    func setStyle() {
        titleLabel.font = FontStyle.title.font()
        titleLabel.textColor = .white
        self.backgroundColor = ColorStyle.mainBackground.color()
    }
    
    func configure(kindList: FilmKindList) {
        self.kindList = kindList
        fillData()
        setStyle()
    }
}
