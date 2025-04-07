//
//  StocksVC.swift
//  Inverstment
//
//  Created by Тася Галкина on 06.04.2025.
//

import UIKit

class StocksVC: UIViewController {
    
    var viewModel: StocksVM!
    
    let tableView = UITableView()
    let stockButton = UILabel()
    let favouriteButton = UIButton()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpView()
    }
    
}

extension StocksVC {
    
    func setUpView() {
        setUpFirstLabel()
//        setUpSecondLabel()
        setUpTableView()
    }
    
    func setUpFirstLabel() {
        view.addSubview(stockButton)
        
        stockButton.text = "Stocks"
        stockButton.font = UIFont(name: "Montserrat-Bold", size: 28)
        stockButton.textColor = .blackColor
        
//        stockButton.titleLabel?.text = "Stocks"
//        stockButton.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 28)
//        stockButton.titleLabel?.textColor = .blackColor
//        stockButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        stockButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stockButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stockButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }
    
    func setUpSecondLabel() {
        view.addSubview(favouriteButton)
        
        favouriteButton.titleLabel?.text = "Favourite"
        favouriteButton.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 18)
        favouriteButton.titleLabel?.textColor = .grayTextColor
        favouriteButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        favouriteButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            favouriteButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            favouriteButton.leadingAnchor.constraint(equalTo: stockButton.trailingAnchor, constant: 20)
        ])
    }
    
    func setUpTableView() {
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(StocksCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        tableView.delegate = self
        tableView.dataSource = self
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: stockButton.bottomAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
}

extension StocksVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.stocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? StocksCell else {
            return UITableViewCell()
        }
        cell.createCell(stocksInfo: viewModel.stocks[indexPath.row])
        cell.buttonAction = {
            self.viewModel.changeFavouriteStatus(id: indexPath.row)
            self.tableView.reloadData()
            print("hi2 \(indexPath.row)")
        }
        cell.selectionStyle = .none
        return cell
    }
    
    
}

