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
        lbl.font = UIFont.boldSystemFont(ofSize: 25)
        return lbl
    }()
    
    private let positionLabel: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    
    private let ratingLabel: UILabel = {
        let lbl = UILabel()
        
        return lbl
    }()
    
    private let percLabel: UILabel = {
        let lbl = UILabel()
        
        return lbl
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
        positionLabel.text = "RANK: \(player.rank)"
        ratingLabel.text = "RATING: \(player.rating)"
        percLabel.text = "WINS: \(player.winPercentage)%"
    }
    
    private func prepareView(){
        backgroundColor = .white
        
        prepareNameLabelStyle()
        preparePositionLabelStyle()
        prepareRatingLabelStyle()
        preparePercLabelStyle()
        prepareArrowImageViewStyle()
    }
    
    private func prepareNameLabelStyle(){
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(10)
        }
    }
    
    private func preparePositionLabelStyle(){
        addSubview(positionLabel)
        positionLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
        }

    }
    
    private func prepareRatingLabelStyle(){
        addSubview(ratingLabel)
        ratingLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(positionLabel.snp.bottom).offset(10)
        }

    }
    
    private func preparePercLabelStyle(){
        addSubview(percLabel)
        percLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(ratingLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
    private func prepareArrowImageViewStyle(){
        addSubview(arrowImageView)
        arrowImageView.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo(15)
        }
    }
}
