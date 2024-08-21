//
//  FilmTableViewVC.swift
//  BlockBuster
//
//  Created by Adrian Aranda Campanario on 25/7/24.
//

import Foundation
import UIKit

protocol FilmTableViewDelegate: AnyObject {
    func filmPressed()
}

class FilmTableViewVC: UIViewController {
    
    @IBOutlet weak var noElementLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var films: [FilmModel] = []
    weak var delegate: FilmTableViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.register(UINib(nibName: "FilmCell", bundle: nil), forCellReuseIdentifier: "FilmCell")
        setStyle()
    }
    
    func setStyle() {
        noElementLabel.text = "NO_ELEMENTS".localizable
        noElementLabel.font = UIFont.systemFont(ofSize: 16)
    }
    
    func reloadData() {
        if tableView != nil {
            tableView.reloadData()
        }
    }
    
    func configure(films: [FilmModel]) {
        self.films.removeAll()
        self.films = films
        reloadData()
    }
}

extension FilmTableViewVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        noElementLabel.isHidden = films.count > 0 ? true : false
        return films.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilmCell", for: indexPath) as! FilmCell
        
        let film = films[indexPath.row]
        cell.configure(film: film)
        return cell
    }
}
