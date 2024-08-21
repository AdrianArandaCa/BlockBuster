//
//  FilmSearchVC.swift
//  BlockBuster
//
//  Created by Adrian Aranda Campanario on 25/7/24.
//

import UIKit
protocol FilmSearchDelegate: AnyObject {
    func searchFilm(name: String)
}

class FilmSearchVC: UIViewController, UITextFieldDelegate {
    var isLoading: Bool = false
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    
    weak var delegate: FilmSearchDelegate?
    var filmCollectionViewVC: FilmCollectionViewVC?
    
    var isEdit = false
 
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        setStyle()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let collectionViewVC = segue.destination as? FilmCollectionViewVC {
            filmCollectionViewVC = collectionViewVC
            filmCollectionViewVC?.delegate = self
        }
    }
    
    func setStyle() {
        titleLabel.textAlignment = .left
        titleLabel.textColor = .white
        titleLabel.text = "SEARCH_FILM".localizable
        textField.borderStyle = .roundedRect
        textField.returnKeyType = .search
        iconButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        titleLabel.font = FontStyle.title.font()
        view.backgroundColor = ColorStyle.mainBackground.color()
        textField.backgroundColor = ColorStyle.textFieldBackground.color()
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = ColorStyle.textFieldBorder.color().cgColor
        textField.layer.cornerRadius = 8.0
        textField.textColor = ColorStyle.textTextField.color()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if let searchText = textField.text {
            delegate?.searchFilm(name: searchText)
        }
        swipeTextFieldIcon()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        swipeTextFieldIcon()
    }
    
    func swipeTextFieldIcon() {
        isEdit.toggle()
        iconButton.setImage(UIImage(systemName: isEdit ? "xmark.circle.fill" : "magnifyingglass"), for: .normal)
    }
    
    @IBAction func iconButtonPressed(_ sender: Any) {
        clearTextTextField()
    }
    
    func clearTextTextField() {
        guard let _ = textField.text else {
            return
        }
        textField.text = ""
    }
    
    func configure(films: [FilmModel], kindList: FilmKindList) {
        guard let filmCollectionViewVC = filmCollectionViewVC else {
            return
        }
        
        filmCollectionViewVC.configure(films: films, kindList: kindList)
    }
}

extension FilmSearchVC: FilmCollectionViewDelegate {
    func filmPressed() {
        
    }
    
    func loadMoreData(kindList: FilmKindList) {
        
    }
}
