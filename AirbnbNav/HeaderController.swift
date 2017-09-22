//
//  HeaderController.swift
//  AirbnbNav
//
//  Created by Leonardo Dominguez on 9/19/17.
//  Copyright © 2017 Leonardo Dominguez. All rights reserved.
//

import UIKit

enum HeaderSizes {
    case min
    case med
    case max
}

protocol HeaderControllerDelegate {
    func didCollapse()
    func didExpand()
}

class HeaderController: UIViewController {
    
    let tableView: UITableView = {
        let tv = UITableView(frame: .zero)
        return tv
    }()
    
    // Status bar
    
    var isHiddenStatusBar: Bool = false {
        didSet {
            UIView.animate(withDuration: 0.3) {
                self.setNeedsStatusBarAppearanceUpdate()
            }
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return isHiddenStatusBar
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if currentHeaderSize == .min {
        return .default
        }
        return .lightContent
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .fade
    }
    
    let maxHeight: CGFloat = 255
    let medHeight: CGFloat = 85 // 55 del height + 10 padding superior + 10 de padding inferior + 10 statusbar
    let minHeight: CGFloat = 0
    var previousScroll: CGFloat = 0
    var currentHeaderSize: HeaderSizes = .max
    var currentHeaderHeight: NSLayoutConstraint?
    
    
    lazy var headerView: HeaderView = {
       let hv = HeaderView(maxHeight: self.maxHeight, medHeight: self.medHeight, minHeight: self.minHeight, paddingBetween: 10)
        return hv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        tableView.delegate = self
        tableView.dataSource = self
        
        headerView.headerControllerDelegate = self
    }
    
    func setupViews() {
        view.addSubview(headerView)
        view.addSubview(tableView)
        
        currentHeaderHeight = headerView.anchor(top: view.topAnchor, bottom: nil, right: view.rightAnchor, left: view.leftAnchor, topConstant: 0, bottomConstant: 0, rightConstant: 0, leftConstant: 0, widthConstant: 0, heightConstant: maxHeight)[3]
        
        _ = tableView.anchor(top: headerView.bottomAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, left: view.leftAnchor)
    }

}

extension HeaderController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel!.text = "Cell \(indexPath.row)"
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let absoluteTop: CGFloat = 0
        let absoluteBottom: CGFloat = scrollView.contentSize.height - scrollView.frame.height
        let scrollRange: CGFloat = scrollView.contentOffset.y - previousScroll
        
        let isScrollingDown = scrollView.contentOffset.y > previousScroll && scrollView.contentOffset.y > absoluteTop
        let isScrollingUp = scrollView.contentOffset.y < previousScroll && scrollView.contentOffset.y < absoluteBottom
        var newHeight: CGFloat = currentHeaderHeight!.constant
        if isScrollingDown {
            newHeight = max(minHeight, ((currentHeaderHeight?.constant)! - abs(scrollRange)))
        } else if isScrollingUp {
            newHeight = min(maxHeight, ((currentHeaderHeight?.constant)! + abs(scrollRange)))
        }
        if newHeight != currentHeaderHeight?.constant {
            currentHeaderHeight?.constant = newHeight
            tableView.contentOffset = CGPoint(x: tableView.contentOffset.x, y: previousScroll)
            let minMedAverage: CGFloat = (minHeight + medHeight) / 2
            let medMaxAverage: CGFloat = (medHeight + maxHeight) / 2
            if currentHeaderHeight!.constant < minMedAverage {
                currentHeaderSize = .min
                
            } else if currentHeaderHeight!.constant >= minMedAverage && currentHeaderHeight!.constant < medMaxAverage {
                currentHeaderSize = .med
            } else if currentHeaderHeight!.constant >= medMaxAverage {
                currentHeaderSize = .max
            }
            updateHeader()
        }
        
        previousScroll = scrollView.contentOffset.y
    
    }
    
    func snapHeader(toSize: HeaderSizes) {
        switch toSize {
        case .max:
            currentHeaderHeight?.constant = maxHeight
        case .med:
            currentHeaderHeight?.constant = medHeight
        case .min:
            currentHeaderHeight?.constant = minHeight
        }
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        snapHeader(toSize: currentHeaderSize)
        updateHeader()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            snapHeader(toSize: currentHeaderSize)
            updateHeader()
        }
    }
    
    func updateHeader() {
        let range = maxHeight - medHeight
        print(range)
        print("Current \(currentHeaderHeight!.constant)")
        print(" Diferencia: \(currentHeaderHeight!.constant - medHeight)")
        let percent = (currentHeaderHeight!.constant - medHeight) / range
        headerView.updateHeader(percentage: percent)
        
        // Status bar
        isHiddenStatusBar = currentHeaderHeight!.constant < (medHeight / 2) && currentHeaderHeight!.constant > 0 ? true : false
    }
}

extension HeaderController: HeaderControllerDelegate {
    
    func didExpand() {
        print("")
    }
    
    func didCollapse() {
        snapHeader(toSize: .min)
    }
}

