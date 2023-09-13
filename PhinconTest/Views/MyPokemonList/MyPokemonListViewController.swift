//
//  MyPokemonListViewController.swift
//  PhinconTest
//
//  Created by reza pahlevi on 13/09/23.
//

import UIKit

private let DefaultIndentifier = "MyPokemonListCell"

class MyPokemonListViewController: UIViewController {
    
    private lazy var tableView: UITableView = { [unowned self] in
        let tv = UITableView()
        tv.tableFooterView = UIView()
        tv.estimatedRowHeight = 120
        tv.backgroundColor = .white
        tv.register(MyPokemonListCell.self, forCellReuseIdentifier: DefaultIndentifier)
        tv.dataSource = self
        tv.separatorStyle = .singleLine
        tv.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return tv
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    

    private func setupView() {
        title = "My Pokemon List"
        view.backgroundColor = .green
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.right.equalTo(view)
            make.bottom.equalToSuperview()
        }
    }

}

// MARK: - UITableViewDataSource
extension MyPokemonListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RealmManager.shared.getMyPokemonList().count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DefaultIndentifier, for: indexPath) as! MyPokemonListCell
        cell.delegate = self
        cell.mappingData(RealmManager.shared.getMyPokemonList()[indexPath.row])
        return cell
    }
    
}
extension MyPokemonListViewController: MyPokemonListViewDelegate {
    
    func didReleasedPokemon(_ data: MyPokemonList) {
        RealmManager.shared.delete(data)
        tableView.reloadData()
        simpleAlert(message: "Pokemon Released")
    }
    
    func didRenamedPokemon(_ data: MyPokemonList) {
        RealmManager.shared.updateNickNamePokemon(data)
        tableView.reloadData()
    }

}
