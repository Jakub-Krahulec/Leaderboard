//
//  CustomStackView.swift
//  Leaderboard
//
//  Created by Jakub Krahulec on 17.02.2021.
//

import UIKit

class CustomStackView: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        axis = .horizontal
        distribution = .equalSpacing
        alignment = .center
        backgroundColor = .white
        layer.cornerRadius = 10
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
