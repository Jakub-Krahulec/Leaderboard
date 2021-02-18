//
//  LeaderboardTableViewCell.swift
//  Leaderboard
//
//  Created by Jakub Krahulec on 16.02.2021.
//

import UIKit

class LeaderboardTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        lbl.textColor = .black
        return lbl
    }()
    
    private let positionLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 37)
        lbl.textColor = UIColor.systemRed.withAlphaComponent(0.3)
        return lbl
    }()
    
    private let ratingLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.black.withAlphaComponent(0.8)
        lbl.font = UIFont.systemFont(ofSize: 15)
        return lbl
    }()
    
    private let infoStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()
    
    private let arrowImageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "chevron.right")
        img.tintColor = UIColor.black.withAlphaComponent(0.2)
        return img
    }()
    
    public var data: Any?{
        didSet{
            updateView(with: data)
        }
    }
    
    
    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepareView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    private func updateView(with data: Any?){
        guard let player = data as? LeaderboardPlayerModel else {return}
        
        nameLabel.text = player.name
        positionLabel.text = "\(player.rank)."
        ratingLabel.text = "RATING: \(player.rating), WINS: \(player.winPercentage)%"
    }
    
    private func prepareView(){
        backgroundColor = .white
        
        prepareArrowImageViewStyle()
        preparePositionLabelStyle()
        prepareInfoStackStyle()
        
    }
    
    private func prepareInfoStackStyle(){
        infoStack.addArrangedSubview(nameLabel)
        infoStack.addArrangedSubview(ratingLabel)
        
        addSubview(infoStack)
        infoStack.snp.makeConstraints { (make) in
            make.left.equalTo(frame.width / 4)
            make.right.equalTo(arrowImageView.snp.left).inset(-5)
            make.top.equalToSuperview().offset(25)
            make.bottom.equalToSuperview().inset(25)
        }
    }
    
    private func preparePositionLabelStyle(){
        addSubview(positionLabel)
        positionLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
        }
    }
    
    private func prepareArrowImageViewStyle(){
        addSubview(arrowImageView)
        arrowImageView.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(15)
            make.centerY.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo(15)
        }
    }
}
