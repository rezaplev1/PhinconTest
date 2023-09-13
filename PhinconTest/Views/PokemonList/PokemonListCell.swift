//
//  PokemonListCell.swift
//  PhinconTest
//
//  Created by reza pahlevi on 13/09/23.
//

import UIKit
import SnapKit
import SDWebImage

class PokemonListCell: UITableViewCell {
    
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
    
    
    private func setupViews() {
        contentView.backgroundColor = .white
        contentView.addSubview(pokemonImage)
        contentView.addSubview(titleLabel)
        
        pokemonImage.snp.makeConstraints { make in
            make.top.left.right.equalTo(contentView)
            make.size.equalTo(100)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(pokemonImage.snp.bottom)
            make.left.right.equalTo(contentView)
            make.bottom.equalTo(contentView).offset(-16)
        }
    }
    
    func mappingData(_ data: Pokemon){
        titleLabel.text = (data.name ?? "").localizedCapitalized
        pokemonImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
        let imageUrl = URL(string: data.imgUrl ?? "")
        pokemonImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(), options: .highPriority, completed: nil)
    }
    
}
