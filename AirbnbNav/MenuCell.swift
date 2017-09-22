//
//  MenuCell.swift
//  AirbnbNav
//
//  Created by Leonardo Dominguez on 9/21/17.
//  Copyright © 2017 Leonardo Dominguez. All rights reserved.
//

import UIKit

class MenuCell: UICollectionViewCell {
    
    let menuLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 12)
        lbl.textColor = .white
        lbl.textAlignment = .center
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        addSubview(menuLabel)
        
        _ = menuLabel.anchor(top: topAnchor, bottom: bottomAnchor, right: rightAnchor, left: leftAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
