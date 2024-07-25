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
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    weak var delegate: FilmSearchDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        setStyle()
    }
    
    func setStyle() {
        
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        if let text = textField.text {
            delegate?.searchFilm(name: text)
        }
    }
}
