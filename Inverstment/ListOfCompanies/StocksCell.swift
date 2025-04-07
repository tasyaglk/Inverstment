//
//  StocksCell.swift
//  Inverstment
//
//  Created by Тася Галкина on 06.04.2025.
//

import UIKit

final class StocksCell: UITableViewCell {
    
    private let backgroundLayer = UIView()
    private let image = UIImageView()
    private let shortName = UILabel()
    private let fullName = UILabel()
    private let favouriteButton = UIButton()
    private let price = UILabel()
    private let priceChanges = UILabel()
    
    var buttonAction: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setUpbackgroundLayer()
        setUpImage()
        setUpShortName()
        setUpFavouriteButton()
        setUpFullName()
        setUpPrice()
        seUpPriceChanges()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpbackgroundLayer() {
        contentView.addSubview(backgroundLayer)
        
        backgroundLayer.layer.masksToBounds = true
        backgroundLayer.layer.cornerRadius = Constants.cellCornerRadius
        
        backgroundLayer.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundLayer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.cellBackgroundOffset),
            backgroundLayer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.cellBackgroundOffset),
            backgroundLayer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundLayer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    private func setUpImage() {
        backgroundLayer.addSubview(image)
        
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        image.layer.cornerRadius = Constants.imageCornerRadius
        
        image.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: backgroundLayer.topAnchor, constant: Constants.imageOffset),
            image.leadingAnchor.constraint(equalTo: backgroundLayer.leadingAnchor, constant: Constants.imageOffset),
            image.bottomAnchor.constraint(equalTo: backgroundLayer.bottomAnchor, constant: -Constants.imageOffset),
            image.heightAnchor.constraint(equalToConstant: Constants.imageSize),
            image.widthAnchor.constraint(equalToConstant: Constants.imageSize)
        ])
    }
    
    private func setUpShortName() {
        backgroundLayer.addSubview(shortName)
        
        shortName.font = UIFont(name: Constants.boldFont, size: Constants.cellBoldFontSize)
        shortName.textColor = .blackColor
        
        shortName.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            shortName.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: Constants.cellTrailingOffset),
            shortName.topAnchor.constraint(equalTo: backgroundLayer.topAnchor, constant: Constants.cellTopOffset),
        ])
    }
    
    private func setUpFavouriteButton() {
        backgroundLayer.addSubview(favouriteButton)
        
        favouriteButton.contentMode = .scaleAspectFit
        
        favouriteButton.addTarget(self, action: #selector(favouriteButtonTapped), for: .touchUpInside)
        
        favouriteButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            favouriteButton.bottomAnchor.constraint(equalTo: shortName.bottomAnchor),
            favouriteButton.topAnchor.constraint(equalTo: shortName.topAnchor),
            favouriteButton.leadingAnchor.constraint(equalTo: shortName.trailingAnchor, constant: Constants.cellLeadingOffset),
            favouriteButton.heightAnchor.constraint(equalToConstant: Constants.buttonSize),
            favouriteButton.widthAnchor.constraint(equalToConstant: Constants.buttonSize)
        ])
    }
    
    private func setUpFullName() {
        backgroundLayer.addSubview(fullName)
        
        fullName.font = UIFont(name: Constants.semiBoldFont, size: Constants.cellSemiBoldFontSize)
        fullName.textColor = .blackColor
        
        fullName.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            fullName.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: Constants.cellTrailingOffset),
            fullName.topAnchor.constraint(equalTo: shortName.bottomAnchor, constant: Constants.cellBottomOffset),
        ])
    }
    
    private func setUpPrice() {
        backgroundLayer.addSubview(price)
        
        price.font = UIFont(name: Constants.boldFont, size: Constants.cellBoldFontSize)
        price.textColor = .blackColor
        
        price.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            price.topAnchor.constraint(equalTo: backgroundLayer.topAnchor, constant: Constants.cellTopOffset),
            price.trailingAnchor.constraint(equalTo: backgroundLayer.trailingAnchor, constant: -Constants.cellTrailingOffset)
        ])
    }
    
    private func seUpPriceChanges() {
        backgroundLayer.addSubview(priceChanges)
        
        priceChanges.font = UIFont(name: Constants.semiBoldFont, size: Constants.cellSemiBoldFontSize)
        
        priceChanges.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            priceChanges.topAnchor.constraint(equalTo: price.bottomAnchor, constant: Constants.cellBottomOffset),
            priceChanges.trailingAnchor.constraint(equalTo: backgroundLayer.trailingAnchor, constant: -Constants.cellTrailingOffset),
        ])
    }
    
    func createCell(stocksInfo: StocksModel) {
        backgroundLayer.backgroundColor = (stocksInfo.id ?? 0) % 2 == 0 ? .grayColor : .white
        image.image = UIImage(named: stocksInfo.imageURL ?? "YNDX")
        shortName.text = stocksInfo.shortName
        fullName.text = stocksInfo.fullName
        let starImage = UIImage(named: stocksInfo.isFavourite ?? false ? "starFilled" : "starNotFilled")
        favouriteButton.setImage(starImage, for: .normal)
        price.text = stocksInfo.price
        priceChanges.text = stocksInfo.priceChanges
        priceChanges.textColor = (stocksInfo.priceChanges?.hasPrefix("+") ?? false) ? .greenColor : .redColor
    }
    
    @objc
    private func favouriteButtonTapped() {
        self.buttonAction?()
    }
}
