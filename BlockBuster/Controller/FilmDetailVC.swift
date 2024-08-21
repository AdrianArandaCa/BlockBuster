//
//  FilmDetailVC.swift
//  BlockBuster
//
//  Created by Adrian Aranda Campanario on 20/8/24.
//

import UIKit

class FilmDetailVC: UIViewController {

    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var titleDescriptionLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var originalTitleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    @IBOutlet weak var playTrailerButton: UIButton!
    
    var film: FilmModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSheet()
        fillData()
        setStyle()
    }
    
    private func setupSheet() {
        guard let sheet = presentationController as? UISheetPresentationController else {
            return
        }
        sheet.detents = [.large()]
        sheet.selectedDetentIdentifier = .large
        sheet.prefersGrabberVisible = true
        sheet.preferredCornerRadius = 20
    }
    
    func fillData() {
        guard let film = film else {
            return
        }
//        self.title = film.title
        posterImageView.image = film.image
        titleDescriptionLabel.text = "ABOUT_MOVIE".localizable
        descriptionLabel.text = film.overview
        playTrailerButton.setTitle("PLAY_TRAILER".localizable, for: .normal)
        originalTitleLabel.text = film.originalTitle
        releaseDateLabel.text = film.releaseDate
    }
    
    func setStyle() {
        guard let _ = film else {
            return
        }
        view.backgroundColor = ColorStyle.mainBackground.color()
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: FontStyle.title.font()
        ]

        posterImageView.contentMode = .scaleAspectFit
        posterImageView.clipsToBounds = true
        
        titleDescriptionLabel.font = FontStyle.subTitle.font()
        titleDescriptionLabel.textColor = .white
        titleDescriptionLabel.textAlignment = .left
        
        descriptionLabel.font = FontStyle.description.font()
        descriptionLabel.adjustsFontSizeToFitWidth = true
        descriptionLabel.minimumScaleFactor = 0.5
        descriptionLabel.textColor = .white
        
        originalTitleLabel.font = FontStyle.description.font()
        originalTitleLabel.textColor = .white
        
        releaseDateLabel.font = FontStyle.description.font()
        releaseDateLabel.textColor = .white
        
        playTrailerButton.titleLabel?.textColor = .white
        playTrailerButton.titleLabel?.font = FontStyle.subTitle.font()
        
    }
    
    @IBAction func playTrailerButtonPressed(_ sender: Any) {
        guard let film = film else {
            return
        }
    }
    
    func configure(film: FilmModel) {
        self.film = film
    }
}
