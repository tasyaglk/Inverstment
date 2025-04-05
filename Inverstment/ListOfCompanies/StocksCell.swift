//
//  StocksCell.swift
//  Inverstment
//
//  Created by Тася Галкина on 06.04.2025.
//

import UIKit

class StocksCell: UITableViewCell {
    var viewModel: StocksVM!
    
    let backgroundLayer = UIView()
    let image = UIImageView()
    let shortName = UILabel()
    let fullName = UILabel()
    let favouriteButton = UIButton()
    let price = UILabel()
    let priceChanges = UILabel()
    
    var buttonAction: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpCell()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StocksCell {
    
    func setUpCell() {
        setUpbackgroundLayer()
        setUpImage()
        setUpShortName()
        setUpFavouriteButton()
        setUpFullName()
        setUpPrice()
        seUpPriceChanges()
    }
    
    func setUpbackgroundLayer() {
        contentView.addSubview(backgroundLayer)
        
        backgroundLayer.layer.masksToBounds = true
        backgroundLayer.layer.cornerRadius = 16
        
        backgroundLayer.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundLayer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            backgroundLayer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            backgroundLayer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundLayer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    func setUpImage() {
        backgroundLayer.addSubview(image)
        
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 12
        
        image.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: backgroundLayer.topAnchor, constant: 8),
            image.leadingAnchor.constraint(equalTo: backgroundLayer.leadingAnchor, constant: 8),
            image.bottomAnchor.constraint(equalTo: backgroundLayer.bottomAnchor, constant: -8),
            image.heightAnchor.constraint(equalToConstant: 52),
            image.widthAnchor.constraint(equalToConstant: 52)
        ])
    }
    
    func setUpShortName() {
        backgroundLayer.addSubview(shortName)
        
        shortName.font = UIFont(name: "Montserrat-Bold", size: 18)
        shortName.textColor = .blackColor
        
        shortName.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            shortName.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 12),
            shortName.topAnchor.constraint(equalTo: backgroundLayer.topAnchor, constant: 14),
        ])
    }
    
    func setUpFavouriteButton() { //!!!!!
        backgroundLayer.addSubview(favouriteButton)
        
        favouriteButton.contentMode = .scaleAspectFit
        
        favouriteButton.addTarget(self, action: #selector(favouriteButtonTapped), for: .touchUpInside)
        
        favouriteButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            favouriteButton.bottomAnchor.constraint(equalTo: shortName.bottomAnchor),
            favouriteButton.topAnchor.constraint(equalTo: shortName.topAnchor),
            favouriteButton.leadingAnchor.constraint(equalTo: shortName.trailingAnchor, constant: 6),
            favouriteButton.heightAnchor.constraint(equalToConstant: 16),
            favouriteButton.widthAnchor.constraint(equalToConstant: 16)
        ])
    }
    
    func setUpFullName() {
        backgroundLayer.addSubview(fullName)
        
        fullName.font = UIFont(name: "Montserrat-SemiBold", size: 12)
        fullName.textColor = .blackColor
        
        fullName.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            fullName.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 12),
            fullName.topAnchor.constraint(equalTo: shortName.bottomAnchor, constant: 2),
        ])
    }
    
    func setUpPrice() {
        backgroundLayer.addSubview(price)
        
        price.font = UIFont(name: "Montserrat-Bold", size: 18)
        price.textColor = .blackColor
        
        price.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            price.topAnchor.constraint(equalTo: backgroundLayer.topAnchor, constant: 14),
            price.trailingAnchor.constraint(equalTo: backgroundLayer.trailingAnchor, constant: -17)
        ])
    }
    
    func seUpPriceChanges() {
        backgroundLayer.addSubview(priceChanges)
        
        priceChanges.font = UIFont(name: "Montserrat-SemiBold", size: 12)
        
        priceChanges.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            priceChanges.topAnchor.constraint(equalTo: price.bottomAnchor, constant: 2),
            priceChanges.trailingAnchor.constraint(equalTo: backgroundLayer.trailingAnchor, constant: -17),
        ])
    }
}

extension StocksCell {
    
    func createCell(stocksInfo: StocksModel) {
        backgroundLayer.backgroundColor = stocksInfo.id! % 2 == 0 ? .grayColor : .white
        image.image = UIImage(named: stocksInfo.imageURL ?? "YNDX")
        shortName.text = stocksInfo.shortName
        fullName.text = stocksInfo.fullName
        let starImage = UIImage(named: stocksInfo.isFavourite! ? "starFilled" : "starNotFilled")
        favouriteButton.setImage(starImage, for: .normal)
        price.text = stocksInfo.price
        priceChanges.text = stocksInfo.priceChanges
        priceChanges.textColor = stocksInfo.priceChanges!.hasPrefix("+") ? .greenColor : .redColor
    }
    
    @objc
    func favouriteButtonTapped() {
        self.buttonAction?()
    }
}

