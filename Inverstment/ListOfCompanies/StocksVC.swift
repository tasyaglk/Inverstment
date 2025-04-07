//
//  StocksVC.swift
//  Inverstment
//
//  Created by Тася Галкина on 06.04.2025.
//

import UIKit

class StocksVC: UIViewController {
    
    var viewModel: StocksVM
    
    private let tableView = UITableView()
    private let stockButton = UILabel()
    private let favouriteButton = UIButton()
    
    init(stocksViewModel: StocksVM) {
        self.viewModel = stocksViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpView()
    }
    
    private func setUpView() {
        setUpFirstLabel()
        //        setUpSecondLabel()
        setUpTableView()
    }
    
    private func setUpFirstLabel() {
        view.addSubview(stockButton)
        
        stockButton.text = "Stocks"
        stockButton.font = UIFont(name: "Montserrat-Bold", size: Constants.titleFontSize)
        stockButton.textColor = .blackColor
        
        //        stockButton.titleLabel?.text = "Stocks"
        //        stockButton.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: Constants.boldFontSize)
        //        stockButton.titleLabel?.textColor = .blackColor
        //        stockButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        stockButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stockButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stockButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.verticalOffset)
        ])
    }
    
    private func setUpSecondLabel() {
        view.addSubview(favouriteButton)
        
        favouriteButton.titleLabel?.text = "Favourite"
        favouriteButton.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: Constants.boldFontSize)
        favouriteButton.titleLabel?.textColor = .grayTextColor
        favouriteButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        favouriteButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            favouriteButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            favouriteButton.leadingAnchor.constraint(equalTo: stockButton.trailingAnchor, constant: Constants.verticalOffset)
        ])
    }
    
    private func setUpTableView() {
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(StocksCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        tableView.delegate = self
        tableView.dataSource = self
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: stockButton.bottomAnchor, constant: Constants.verticalOffset),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.horizontalOffset),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.horizontalOffset)
        ])
    }
}

extension StocksVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.stocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? StocksCell else {
            return UITableViewCell()
        }
        cell.createCell(stocksInfo: viewModel.stocks[indexPath.row])
        cell.buttonAction = {
            self.viewModel.changeFavouriteStatus(id: indexPath.row)
            self.tableView.reloadData()
        }
        cell.selectionStyle = .none
        return cell
    }
}

