//
//  PlayerCollectionViewCell.swift
//  Leaderboard
//
//  Created by Jakub Krahulec on 16.02.2021.
//

import UIKit

class PlayerCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    
    private let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        return lbl
    }()
    
    private let civLabel: UILabel = {
        let lbl = UILabel()
        
        return lbl
    }()
    
    private let hasWonLabel: UILabel = {
        let lbl = UILabel()
        
        return lbl
    }()
    
    public var data: Any?{
        didSet{
            updateView(with: data)
        }
    }
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Helpers
    
    private func updateView(with data: Any?){
        guard let player = data as? MatchPlayerModel else {return}
        
        nameLabel.text = player.name
        civLabel.text = "Civ: \(player.civ)"
        if let hasWon = player.won{
          //  hasWonLabel.text = hasWon ? "Winner" : "Loser"
            layer.borderColor = hasWon ? UIColor.systemGreen.cgColor : UIColor.systemRed.cgColor
        }
    }
    
    private func prepareView(){
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
        
        backgroundColor = .white
        prepareNameLabelStyle()
        prepareCivLabelStyle()
        prepareHasWonLabel()
    }
    
    private func prepareNameLabelStyle(){
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().inset(10)
        }
    }
    
    private func prepareCivLabelStyle(){
        contentView.addSubview(civLabel)
        civLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(15)
        }
    }
    
    private func prepareHasWonLabel(){
        contentView.addSubview(hasWonLabel)
        hasWonLabel.snp.makeConstraints { (make) in
            make.top.equalTo(civLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().inset(10)
          //  make.bottom.equalToSuperview().inset(15)
        }
    }
}
