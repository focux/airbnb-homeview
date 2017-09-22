//
//  Navbar.swift
//  AirbnbNav
//
//  Created by Leonardo Dominguez on 9/19/17.
//  Copyright © 2017 Leonardo Dominguez. All rights reserved.
//

import UIKit

class HeaderView: UIView {
    
    // MARK: Setup properties
    
    var maxHeight: CGFloat!
    var medHeight: CGFloat!
    var minHeight: CGFloat!
    var containerPadding: CGFloat!
    let containersHeight: CGFloat = 55
    var collapseBtnHeight: NSLayoutConstraint?
    var headerControllerDelegate: HeaderControllerDelegate?

    // MARK: Navbar Containers
    
    let minView: UIView = {
        let v = UIView()
        v.backgroundColor = Theme.PRIMARY_COLOR
        return v
    }()
    
    let medView: UIView = {
        let v = UIView()
        v.backgroundColor = Theme.PRIMARY_COLOR
        return v
    }()
    
    let maxView: UIView = {
        let v = UIView()
        v.backgroundColor = Theme.PRIMARY_COLOR
        return v
    }()
    
    let menuContainer: UIView = {
        let v = UIView()
        v.backgroundColor = Theme.PRIMARY_DARK_COLOR
        return v
    }()
    
    
    // MARK: Navbar Views
    
    let collapseBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "Collapse Arrow-25 (1)").withRenderingMode(.alwaysOriginal), for: .normal)
        return btn
    }()
    
    //MARK: minContainer
    
    let minIcon: UIImageView = {
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "Globe Earth-25")
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let minIconCollapse: UIImageView = {
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "Search-25")
        img.contentMode = .scaleAspectFit
        img.alpha = 0
        return img
    }()
    
    let minLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Anywhere"
        lbl.textAlignment = .left
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textColor = .white
        return lbl
    }()
    
    let minLabelCollapse: UILabel = {
        let lbl = UILabel()
        lbl.text = "Anywhere • Anytime • 1 Guest"
        lbl.textAlignment = .left
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textColor = .white
        lbl.alpha = 0
        return lbl
    }()
    
    //MARK: medContainer
    
    let medIcon: UIImageView = {
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "Calendar-100")
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let medLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Anytime"
        lbl.textAlignment = .left
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textColor = .white
        return lbl
    }()
    
    //MARK: maxContainer
    
    let maxIcon: UIImageView = {
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "Family Man Woman-25")
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let maxLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "1 guest"
        lbl.textAlignment = .left
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textColor = .white
        return lbl
    }()
    
    let backgroundGradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        gradient.colors = [Theme.PRIMARY_COLOR.cgColor, Theme.PRIMARY_DARK_COLOR.cgColor]
        return gradient
    }()
    
    override var bounds: CGRect {
        didSet {
            backgroundGradient.frame = bounds
        }
    }
    
    let menuView: MenuView = {
        let mv = MenuView()
        return mv
    }()
    
    let whiteView: UIView = {
        let wv = UIView()
        wv.backgroundColor = .white
        wv.alpha = 0
        return wv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Theme.PRIMARY_DARK_COLOR
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(maxHeight: CGFloat, medHeight: CGFloat, minHeight: CGFloat, paddingBetween containerPadding: CGFloat) {
        self.init(frame: CGRect.zero)
        self.maxHeight = maxHeight
        self.medHeight = medHeight
        self.minHeight = minHeight
        self.containerPadding = containerPadding
        
        collapseBtn.addTarget(self, action: #selector(handleCollapse), for: .touchUpInside)
        setupViews()
    }
    
    override func layoutSubviews() {
//                    layer.insertSublayer(backgroundGradient, at: 0)
        addSubview(menuView)
        _ = menuView.anchor(top: menuContainer.topAnchor, bottom: menuContainer.bottomAnchor, right: menuContainer.rightAnchor, left: menuContainer.leftAnchor)
    }
    
    func setupViews() {
        addSubview(collapseBtn)
        addSubview(minView)
        addSubview(medView)
        addSubview(maxView)
        addSubview(menuContainer)
        addSubview(whiteView)
        
        minView.addSubview(minIcon)
        minView.addSubview(minLabel)
        minView.addSubview(minLabelCollapse)
        minView.addSubview(minIconCollapse)
        
        medView.addSubview(medIcon)
        medView.addSubview(medLabel)
        
        maxView.addSubview(maxIcon)
        maxView.addSubview(maxLabel)
        
        collapseBtnHeight = collapseBtn.anchor(top: topAnchor, bottom: nil, right: nil, left: leftAnchor, topConstant: 20, bottomConstant: 0, rightConstant: 0, leftConstant: containerPadding, widthConstant: 30, heightConstant: 30)[0]
        
        _ = minView.anchor(top: collapseBtn.bottomAnchor, bottom: nil, right: rightAnchor, left: leftAnchor, topConstant: containerPadding, bottomConstant: 0, rightConstant: containerPadding, leftConstant: containerPadding, widthConstant: 0, heightConstant: containersHeight)
        
        _ = medView.anchor(top: minView.bottomAnchor, bottom: nil, right: minView.rightAnchor, left: minView.leftAnchor, topConstant: containerPadding, bottomConstant: 0, rightConstant: 0, leftConstant: 0, widthConstant: 0, heightConstant: containersHeight)
        
        _ = maxView.anchor(top: medView.bottomAnchor, bottom: nil, right: minView.rightAnchor, left: minView.leftAnchor, topConstant: containerPadding, bottomConstant: 0, rightConstant: 0, leftConstant: 0, widthConstant: 0, heightConstant: containersHeight)
        
        _ = menuContainer.anchor(top: nil, bottom: bottomAnchor, right: minView.rightAnchor, left: minView.leftAnchor, topConstant: 0, bottomConstant: 0, rightConstant: 0, leftConstant: 0, widthConstant: 0, heightConstant: containersHeight)
        
        _ = whiteView.anchor(top: topAnchor, bottom: bottomAnchor, right: rightAnchor, left: leftAnchor, topConstant: 0, bottomConstant: 0, rightConstant: 0, leftConstant: 0, widthConstant: 0, heightConstant: 0)
        
        //Min Subviews
        
        _ = minIcon.anchor(top: minView.topAnchor, bottom: minView.bottomAnchor, right: nil, left: minView.leftAnchor, topConstant: 5, bottomConstant: 5, rightConstant: 0, leftConstant: 5, widthConstant: 30, heightConstant: 0)
        
        _ = minIconCollapse.anchor(top: minView.topAnchor, bottom: minView.bottomAnchor, right: nil, left: minView.leftAnchor, topConstant: 5, bottomConstant: 5, rightConstant: 0, leftConstant: 5, widthConstant: 30, heightConstant: 0)
        
        _ = minLabel.anchor(top: minView.topAnchor, bottom: minView.bottomAnchor, right: minView.rightAnchor, left: minIcon.rightAnchor, topConstant: 0, bottomConstant: 0, rightConstant: 0, leftConstant: 5, widthConstant: 0, heightConstant: 0)
        
        _ = minLabelCollapse.anchor(top: minView.topAnchor, bottom: minView.bottomAnchor, right: minView.rightAnchor, left: minIcon.rightAnchor, topConstant: 0, bottomConstant: 0, rightConstant: 0, leftConstant: 5, widthConstant: 0, heightConstant: 0)
        
        //Med Subviews
        
        _ = medIcon.anchor(top: medView.topAnchor, bottom: medView.bottomAnchor, right: nil, left: medView.leftAnchor, topConstant: 5, bottomConstant: 5, rightConstant: 0, leftConstant: 5, widthConstant: 30, heightConstant: 0)
        
        _ = medLabel.anchor(top: medView.topAnchor, bottom: medView.bottomAnchor, right: medView.rightAnchor, left: medIcon.rightAnchor, topConstant: 0, bottomConstant: 0, rightConstant: 0, leftConstant: 5, widthConstant: 0, heightConstant: 0)
        
        //Max Subviews
        
        _ = maxIcon.anchor(top: maxView.topAnchor, bottom: maxView.bottomAnchor, right: nil, left: maxView.leftAnchor, topConstant: 5, bottomConstant: 5, rightConstant: 0, leftConstant: 5, widthConstant: 30, heightConstant: 0)
        
        _ = maxLabel.anchor(top: maxView.topAnchor, bottom: maxView.bottomAnchor, right: maxView.rightAnchor, left: maxIcon.rightAnchor, topConstant: 0, bottomConstant: 0, rightConstant: 0, leftConstant: 5, widthConstant: 0, heightConstant: 0)
        
        
    }
    
    func updateHeader(percentage: CGFloat, currentHeaderHeight: CGFloat) {
        self.collapseBtnHeight?.constant = (percentage - 1) * 40 + 20 //20 es el constant por defecto, el multiplo de 40 es lo que debe subir el btn, deberia ser 20 pero puse 40 para contrarestar el 20
        UIView.animate(withDuration: 0.2, animations: {
            self.maxView.alpha = percentage
            self.medView.alpha = percentage
            self.medLabel.alpha = percentage
            self.medIcon.alpha = percentage
            self.minLabel.alpha = percentage
            self.minLabelCollapse.alpha = -percentage + 1
            self.minIcon.alpha = percentage
            self.minIconCollapse.alpha = -percentage + 1
            if currentHeaderHeight <= self.medHeight {
                let medPercentage = (currentHeaderHeight - self.minHeight) / (self.medHeight - self.minHeight)
                self.whiteView.alpha = -medPercentage + 1
                self.menuView.changeFontColor = medPercentage
                
            }
            
        })
    }
    
    func handleCollapse() {
        headerControllerDelegate?.didCollapse()
    }
}
