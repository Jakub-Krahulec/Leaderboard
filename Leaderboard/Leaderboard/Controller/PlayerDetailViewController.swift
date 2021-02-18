//
//  PlayerDetailViewController.swift
//  Leaderboard
//
//  Created by Jakub Krahulec on 16.02.2021.
//

import UIKit
import SnapKit
import Alamofire

class PlayerDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    public var playerId: Int? {
        didSet{
            fetchData()
        }
    }
    
    private let cellId = "cellid"
    private var hasFetchedData = false
    
    private var players = [MatchPlayerModel](){
        didSet{
            collectionView.reloadSections(IndexSet(integer: 0))
        }
    }
    
    private let collectionView: UICollectionView = {
        let col = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        col.backgroundColor = .clear
        if let layout = col.collectionViewLayout as? UICollectionViewFlowLayout{
            layout.minimumLineSpacing = 5
        }
        return col
    }()
    
    private let matchLenLabel: UILabel = {
       let lbl = UILabel()
        
        return lbl
    }()
    
    private let mapNameLabel: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    
    private let mapImageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "map")
        img.tintColor = .brown
        return img
    }()
    
    private let timeImageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "timer")
        img.tintColor = .systemBlue
        return img
    }()
    
    private let mapStack = CustomStackView()
    private let timeStack = CustomStackView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !hasFetchedData{
            showLoader()
        }
    }
    
    // MARK: - Actions
    
    
    
    // MARK: - Helpers
    
    @objc private func fetchData(){
        guard let id = playerId else {return}
        let url = "https://aoe2.net/api/player/lastmatch?game=aoe2de&profile_id=\(id)"
        let _ = NetworkService.shared.performRequest(from: url, model: LastMatchResponse.self) { [weak self] (result) in
            guard let this = self else {return}
            this.hasFetchedData = true
            switch result{
                case .success(let data):
                    this.players = data.last_match.players
                    this.updateView(with: data)
                    this.dismiss(animated: false, completion: nil)
                case .failure(let error):
                    this.showMessage(withTitle: "ERROR", message: error.localizedDescription)
                    this.dismiss(animated: false, completion: nil)
            }
        }
    }
    
    private func updateView(with data: Any?){
        guard let data = data as? LastMatchResponse else {return}
        title = data.last_match.name
        mapNameLabel.text = "type \(data.last_match.map_type)"
        
        if let time = data.last_match.roundTime{
            matchLenLabel.text = "\(time) minutes"
        } else{
            matchLenLabel.text = "Match has not finished yet"
        }
    }
    
    private func prepareView(){
        view.backgroundColor = .backgroundLight
    
        prepareMapStackStyle()
        prepareTimeStackStyle()
        prepareCollectionViewStyle()
    }
    
    private func prepareCollectionViewStyle(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PlayerCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(5)
            make.top.equalTo(timeStack.snp.bottom).offset(5)
            make.bottom.equalTo(view.safeAreaInsets.bottom)
        }
    }
    
    private func prepareMapStackStyle(){
        mapStack.addArrangedSubview(mapImageView)
        mapStack.addArrangedSubview(mapNameLabel)
        
        view.addSubview(mapStack)
        mapStack.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(5)
            make.right.left.equalToSuperview().inset(5)
            make.height.equalTo(50)
        }
    }
    
    private func prepareTimeStackStyle(){
        timeStack.addArrangedSubview(timeImageView)
        timeStack.addArrangedSubview(matchLenLabel)
        
        view.addSubview(timeStack)
        timeStack.snp.makeConstraints { (make) in
            make.top.equalTo(mapStack.snp.bottom).offset(5)
            make.right.left.equalToSuperview().inset(5)
            make.height.equalTo(50)
        }
    }
}

// MARK: - CollectionView

extension PlayerDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return players.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        if let cell = cell as? PlayerCollectionViewCell{
            cell.data = players[indexPath.row]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 90)
    }
}


