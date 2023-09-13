//
//  PokemonDetailViewController.swift
//  PhinconTest
//
//  Created by reza pahlevi on 13/09/23.
//

import UIKit
import SDWebImage
import SnapKit

class PokemonDetailViewController: UIViewController {
    
    let pokemonImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    var nameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24.0)
        label.text = "-"
        return label
    }()
    
    var detailLabel: UILabel = {
        let label: UILabel = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.text = "-"
        return label
    }()
    
    var catchButton: UIButton = {
        let button = UIButton()
        button.setTitle("Catch", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .lightGray
        button.addTarget(self, action: #selector(didTapCatchButton), for: .touchUpInside)
        return button
    }()
    
    lazy var scrollView: UIScrollView = { [unowned self] in
        let sc = UIScrollView()
        sc.backgroundColor = .clear
        sc.bounces = true
        sc.addSubview(pokemonImage)
        sc.addSubview(nameLabel)
        sc.addSubview(detailLabel)
        
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(sc).offset(40)
            make.left.equalTo(sc).offset(20)
            make.right.equalTo(sc).offset(-20)
            make.width.equalTo(sc.snp.width).offset(-40)
        }
        
        pokemonImage.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(0)
            make.height.equalTo(200)
            make.left.equalTo(sc).offset(20)
            make.right.equalTo(sc).offset(-20)
            make.width.equalTo(sc.snp.width).offset(-40)
        }
        
        detailLabel.snp.makeConstraints { (make) in
            make.top.equalTo(pokemonImage.snp.bottom).offset(0)
            make.left.equalTo(sc).offset(20)
            make.right.equalTo(sc).offset(-20)
            make.width.equalTo(sc.snp.width).offset(-40)
            make.bottom.equalTo(sc).offset(-20)
            
        }
        
        return sc
    }()
    
    var vm = PokemonDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vm.delegate = self
        setupView()
        vm.getPokemonDetail()
        mappingData()
    }
    
    @objc func didTapCatchButton(_ sender: UIButton) {
        if Bool.random() {
            catchAlert()
        }else {
            simpleAlert(message: "Fail catch")
        }
    }
    
    func catchAlert() {
        let alertController = UIAlertController(title: "Yahoo Catch", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter name"
        }
        
        let saveAction = UIAlertAction(title: "Catch", style: .default, handler: { alert -> Void in
            if let textField = alertController.textFields?[0] {
                if let data = self.vm.pokemon {
                    RealmManager.shared.createPokemonData(url: data.url ?? "",
                                                          imageUrl: data.imgUrl ?? "",
                                                          nickName: (textField.text!.count > 0 ? textField.text : data.name) ?? "",
                                                          name: data.name ?? "")
                }
            }
        })
        
        let cancelAction = UIAlertAction(title: "Release", style: .default, handler: {
            (action : UIAlertAction!) -> Void in })
        
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        
        alertController.preferredAction = saveAction
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func setupView() {
        title = "Pokemon Detail"
        view.backgroundColor = .white
        view.addSubview(scrollView)
        view.addSubview(catchButton)
        
        scrollView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.bottom.equalTo(catchButton.snp.top).offset(-16)
        }

        catchButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(view).offset(-30)
            make.height.equalTo(62)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
        }
        
    }
    
    private func mappingData() {
        
        if let data = vm.pokemon {
            nameLabel.text = (data.name ?? "").localizedCapitalized
            pokemonImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
            let imageUrl = URL(string: data.imgUrl ?? "")
            pokemonImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(), options: .highPriority, completed: nil)
        }
    }
}


extension PokemonDetailViewController: PokemonDetailViewModelDelegate {
    func success() {
        if let data = vm.pokemonDetail {
            detailLabel.text = data.moveAndTypeDetail
        }
    }
    
    func failedReq(message: String) {
        simpleAlert(message: message)
        
    }
}
