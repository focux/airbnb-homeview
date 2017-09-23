//
//  MenuView.swift
//  AirbnbNav
//
//  Created by Leonardo Dominguez on 9/21/17.
//  Copyright © 2017 Leonardo Dominguez. All rights reserved.
//

import UIKit

class MenuView: UIView {
    
    var lineViewLeftAnchor: NSLayoutConstraint!
    
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
    
    let lineView: UIView = {
        let lv = UIView()
        lv.backgroundColor = .white
        return lv
    }()
    
    let cellId = "menuCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        print(frame.width)
        lineView.widthAnchor.constraint(equalToConstant: frame.size.width / 4).isActive = true
    }
    
    func setupViews() {
        addSubview(collectionView)
        addSubview(lineView)
        bringSubview(toFront: lineView)
        
        _ = collectionView.anchor(top: topAnchor, bottom: bottomAnchor, right: rightAnchor, left: leftAnchor)
        
        lineViewLeftAnchor = lineView.anchor(top: nil, bottom: bottomAnchor, right: nil, left: leftAnchor, topConstant: 0, bottomConstant: 0, rightConstant: 0, leftConstant: 0, widthConstant: 0, heightConstant: 1.5)[1]
        
        
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(frame.size.width / 4 * CGFloat(indexPath.item))
        self.lineViewLeftAnchor.constant = frame.size.width / 4 * CGFloat(indexPath.item)
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.layoutIfNeeded()
        }, completion: nil)
    }
}
