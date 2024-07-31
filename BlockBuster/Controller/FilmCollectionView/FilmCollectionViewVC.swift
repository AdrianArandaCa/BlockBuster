//
//  FilmCollectionViewVC.swift
//  BlockBuster
//
//  Created by Adrian Aranda Campanario on 31/7/24.
//

import UIKit

enum FilmKindList {
    case search
    case popular
}

protocol FilmCollectionViewDelegate: AnyObject {
    func filmPressed()
    func loadMoreData()
    var isLoading: Bool { get }
}

class FilmCollectionViewVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var noElementLabel: UILabel!
    var films: [FilmModel] = []
    weak var delegate: FilmCollectionViewDelegate?
    let heightCell = 100
    let widthCell = 100
    let spacing = CGFloat(10.0)
    var kindList: FilmKindList = .popular
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "FilmCollectionCell", bundle: nil), forCellWithReuseIdentifier: "FilmCollectionCell")
        self.collectionView.register(UINib(nibName: "FilmCollectionViewHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "FilmCollectionViewHeader")
    }
    
    func setStyle() {
        noElementLabel.text = "No elements"
        noElementLabel.font = UIFont.systemFont(ofSize: 16)
    }
    
    func reloadData() {
        if collectionView != nil {
            collectionView.reloadData()
        }
    }
    
    func addMoreData(films: [FilmModel], kindList: FilmKindList) {
        self.films.append(contentsOf: films)
        self.kindList = kindList
        reloadData()
    }
    
    func configure(films: [FilmModel], kindList: FilmKindList) {
        self.films.removeAll()
        self.films = films
        self.kindList = kindList
        reloadData()
    }
}

extension FilmCollectionViewVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        noElementLabel.isHidden = films.count > 0 ? true : false
        return films.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilmCollectionCell", for: indexPath) as! FilmCollectionCell
        
        let film = films[indexPath.row]
        cell.configure(film: film)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: widthCell, height: heightCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let totalCellWidth = widthCell * numberOfItemsPerRow()
        let totalSpacingWidth = 10 * (numberOfItemsPerRow() - 1)
        let leftInset = (collectionView.frame.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset
        return UIEdgeInsets(top: 10, left: leftInset, bottom: 10, right: rightInset)
    }
    
    private func numberOfItemsPerRow() -> Int {
        let availableWidth = collectionView.frame.width - 20 // Restar el padding de izquierda y derecha (10 cada uno)
        return Int(availableWidth / 110) // 100 para el ancho de la celda + 10 para el espacio mínimo entre celdas
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FilmCollectionViewHeader", for: indexPath) as! FilmCollectionViewHeader
        headerView.titleLabel.text = kindList == .popular ? "Populares" : "Busqueda"
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50) // Ajusta el tamaño de la cabecera según sea necesario
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            if !delegate!.isLoading {
                delegate?.loadMoreData()
            }
        }
    }
}
