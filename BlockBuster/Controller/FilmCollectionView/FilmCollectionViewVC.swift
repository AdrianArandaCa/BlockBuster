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
    func loadMoreData(kindList: FilmKindList)
    var isLoading: Bool { get }
}

class FilmCollectionViewVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var noElementLabel: UILabel!
    var films: [FilmModel] = []
    weak var delegate: FilmCollectionViewDelegate?
    let spacing = CGFloat(3.0)
    var kindList: FilmKindList = .popular
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "FilmCollectionCell", bundle: nil), forCellWithReuseIdentifier: "FilmCollectionCell")
        self.collectionView.register(UINib(nibName: "FilmCollectionViewHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "FilmCollectionViewHeader")
        setStyle()
    }
    
    func setStyle() {
        view.backgroundColor = ColorStyle.mainBackground.color()
        self.collectionView.backgroundColor = ColorStyle.mainBackground.color()
        noElementLabel.text = "NO_ELEMENTS".localizable
        noElementLabel.font = FontStyle.subTitle.font()
        noElementLabel.textColor = .white
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionHeadersPinToVisibleBounds = true
        }
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let film = films[indexPath.row]
        
        if let filmDetailVC = storyboard?.instantiateViewController(withIdentifier: "FilmDetailVC") as? FilmDetailVC {
            filmDetailVC.configure(film: film)
            present(filmDetailVC, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow: CGFloat = 2
        let totalSpacing = (numberOfItemsPerRow - 1) * spacing // Espaciado entre ítems
        let totalWidth = collectionView.bounds.width - totalSpacing
        let itemWidth = totalWidth / numberOfItemsPerRow
        let itemHeight: CGFloat = itemWidth * 1.5
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FilmCollectionViewHeader", for: indexPath) as! FilmCollectionViewHeader
        headerView.configure(kindList: kindList)
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: films.count > 0 ? 50 : 0)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            if !delegate!.isLoading && kindList != .search {
                delegate?.loadMoreData(kindList: kindList)
            }
        }
    }
}
