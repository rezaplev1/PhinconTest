//
//  MyPokemonListCell.swift
//  PhinconTest
//
//  Created by reza pahlevi on 13/09/23.
//

import UIKit
import SnapKit
import SDWebImage

protocol MyPokemonListViewDelegate : AnyObject {
    func didRenamedPokemon(_ data: MyPokemonList)
    func didReleasedPokemon(_ data: MyPokemonList)
    
}

class MyPokemonListCell: UITableViewCell {
    
    weak var delegate: MyPokemonListViewDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var pokemonImage: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    var titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    var releaseButton: UIButton = {
        let button = UIButton()
        button.setTitle("Release", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .lightGray
        button.addTarget(self, action: #selector(didTapReleaseButton), for: .touchUpInside)
        return button
    }()
    
    var renameButton: UIButton = {
        let button = UIButton()
        button.setTitle("Rename", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .lightGray
        button.addTarget(self, action: #selector(didTapRenameButton), for: .touchUpInside)
        return button
    }()
    
    
    private func setupViews() {
        contentView.backgroundColor = .white
        contentView.addSubview(pokemonImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(renameButton)
        contentView.addSubview(releaseButton)
               
        pokemonImage.snp.makeConstraints { make in
            make.top.left.right.equalTo(contentView)
            make.size.equalTo(100)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(pokemonImage.snp.bottom)
            make.left.right.equalTo(contentView)
          
        }
        
        renameButton.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.height.equalTo(32)
            make.left.equalTo(contentView).offset(20)
            make.right.equalTo(contentView).offset(-20)
        }
        
        releaseButton.snp.makeConstraints { (make) in
            make.top.equalTo(renameButton.snp.bottom).offset(8)
            make.height.equalTo(32)
            make.left.equalTo(contentView).offset(20)
            make.right.equalTo(contentView).offset(-20)
            make.bottom.equalTo(contentView).offset(-16)
        }
    }
    
    var myPokemonList: MyPokemonList?
    
    func mappingData(_ data: MyPokemonList){
        myPokemonList = data
        titleLabel.text = data.nickNameUpdated.localizedCapitalized
        pokemonImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
        let imageUrl = URL(string: data.imageURL)
        pokemonImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(), options: .highPriority, completed: nil)
    }
    
    @objc func didTapReleaseButton(_ sender: UIButton) {
        if let data = myPokemonList {
            delegate?.didReleasedPokemon(data)
        }
        
    }
 
    @objc func didTapRenameButton(_ sender: UIButton) {
        if let data = myPokemonList {
            delegate?.didRenamedPokemon(data)
        }
        
    }
}
