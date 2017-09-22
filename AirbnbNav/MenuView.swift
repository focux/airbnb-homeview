//
//  MenuView.swift
//  AirbnbNav
//
//  Created by Leonardo Dominguez on 9/21/17.
//  Copyright © 2017 Leonardo Dominguez. All rights reserved.
//

import UIKit

class MenuView: UIView {
    
    let menuItems: [String] = ["FOR YOU", "HOMES", "EXPERIENCE", "PLACES"]
    
    fileprivate var fontColor: UIColor = UIColor(white: 1, alpha: 1) {
        didSet {
            collectionView.reloadData()
        }
    }
    var changeFontColor: CGFloat = 0 {
        didSet {
            fontColor = UIColor(white: changeFontColor, alpha: 1)
        }
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    let cellId = "menuCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.backgroundColor = .clear
        
        print("menuview")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(collectionView)
        
        _ = collectionView.anchor(top: topAnchor, bottom: bottomAnchor, right: rightAnchor, left: leftAnchor)
    }
}

extension MenuView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? MenuCell {
            cell.menuLabel.text = menuItems[indexPath.row]
            cell.menuLabel.textColor = fontColor
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.size.width / 4, height: frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
