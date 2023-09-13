//
//  PokemonListViewController.swift
//  PhinconTest
//
//  Created by reza pahlevi on 13/09/23.
//

import UIKit
import SnapKit

private let DefaultIndentifier = "PokemonListCell"

class PokemonListViewController: UIViewController {

    private lazy var tableView: UITableView = { [unowned self] in
        let tv = UITableView()
        tv.tableFooterView = UIView()
        tv.estimatedRowHeight = 120
        tv.backgroundColor = .white
        tv.register(PokemonListCell.self, forCellReuseIdentifier: DefaultIndentifier)
        tv.dataSource = self
        tv.delegate = self
        tv.separatorStyle = .singleLine
        tv.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return tv
    }()
    
    var myPokemonListButton: UIButton = {
        let button = UIButton()
        button.setTitle("My Pokemon List", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .lightGray
        button.addTarget(self, action: #selector(didTapMyPokemonListButton), for: .touchUpInside)
        return button
    }()
    
    var vm = PokemonListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        vm.delegate = self
        vm.getPokemonList()
    }
    

    private func setupView() {
        title = "Pokemon List"
        view.backgroundColor = .green
        view.addSubview(tableView)
        view.addSubview(myPokemonListButton)
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.right.equalTo(view)
            make.bottom.equalTo(myPokemonListButton.snp.top).offset(-16)
        }

        myPokemonListButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(view).offset(-30)
            make.height.equalTo(62)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
        }
    }
    
    @objc func didTapMyPokemonListButton(_ sender: UIButton) {
        let vc = MyPokemonListViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension PokemonListViewController: PokemonListViewModelDelegate {
    func success() {
        tableView.spinnerFooter(start: false)
        tableView.reloadData()
    }
    
    func failedReq(message: String) {
        simpleAlert(message: message)
    }
    
    func hideTableviewFooter(isHidden: Bool) {
        self.tableView.tableFooterView?.isHidden = isHidden
    }

    
}

// MARK: - UITableViewDataSource
extension PokemonListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.pokemonList?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let data = vm.pokemonList, !vm.onGoing && indexPath.row == data.count - 1{
            self.tableView.spinnerFooter(start: true)
            vm.getPokemonList()

        }
        let cell = tableView.dequeueReusableCell(withIdentifier: DefaultIndentifier, for: indexPath) as! PokemonListCell
        if let data = vm.pokemonList?[indexPath.row]{
            cell.mappingData(data)
        }
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension PokemonListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let data = vm.pokemonList?[indexPath.row] {
            let vc = PokemonDetailViewController()
            vc.vm.pokemon = data
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
}
