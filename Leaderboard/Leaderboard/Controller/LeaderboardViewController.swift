//
//  ViewController.swift
//  Leaderboard
//
//  Created by Jakub Krahulec on 16.02.2021.
//

import UIKit
import SnapKit
import Alamofire

class LeaderboardViewController: UIViewController {
    
    // MARK: - Properties
    private let cellId = "cellid"
    private var hasFetchedData = false
    private var players = [LeaderboardPlayerModel](){
        didSet{
            refreshControl.endRefreshing()
            tableView.reloadData()
        }
    }
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.rowHeight = UITableView.automaticDimension
        table.separatorInset = .zero
        table.separatorStyle = .singleLine
        return table
    }()
    
    private let refreshControl = UIRefreshControl()

    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    // MARK: - Actions
    
    
    
    // MARK: - Helpers
    
    @objc private func fetchData(){
        let url = "https://aoe2.net/api/leaderboard?game=aoe2de&leaderboard_id=3&start=1&count=20"
        let _ = NetworkService.shared.performRequest(from: url, model: LeaderboardResponse.self) { [weak self] (result) in
            guard let this = self else {return}
            this.hasFetchedData = true
            switch result{
                case .success(let data):
                    this.players = data.leaderboard
                case .failure(let error):
                    this.showMessage(withTitle: "ERROR", message: error.localizedDescription)
            }
            this.dismiss(animated: false, completion: nil)
        }
    }
    
    private func prepareView(){
        view.backgroundColor = .white
        title = "Leaderboard"
        
        prepareTableViewStyle()
    }
    
    private func prepareTableViewStyle(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LeaderboardTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}


// MARK: - TableView

extension LeaderboardViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        if let cell = cell as? LeaderboardTableViewCell{
            cell.data = players[indexPath.row]            
            return cell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = PlayerDetailViewController()
        controller.playerId = players[indexPath.row].profile_id
        navigationController?.pushViewController(controller, animated: true)
    }
}
