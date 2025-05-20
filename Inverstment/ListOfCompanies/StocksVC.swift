//
//  StocksVC.swift
//  Inverstment
//
//  Created by Тася Галкина on 06.04.2025.
//

import UIKit

class StocksVC: UIViewController {
    
    private var viewModel: StocksVM
    
    private let searchBar = CustomSearchBar()
    private let tableView = UITableView()
    private let stockButton = UIButton()
    private let favouriteButton = UIButton()
    private let stackView = UIStackView()
    
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
        setUpSearchBar()
        setUpStockButton()
        setUpFavouriteButton()
        setUpStack()
        setUpTableView()
    }
    
    private func setUpSearchBar() {
        view.addSubview(searchBar)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        searchBar.onTextChange = { [weak self] text in
            self?.viewModel.search(text: text)
            self?.tableView.reloadData()
        }
        
        searchBar.onClear = { [weak self] in
            self?.viewModel.clearSearch()
            self?.tableView.reloadData()
        }
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.horizontalOffset),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.horizontalOffset),
            searchBar.heightAnchor.constraint(equalToConstant: Constants.searchBarHeight)
        ])
    }
    
    private func setUpStack() {
        view.addSubview(stackView)
        
        stackView.axis = .horizontal
        stackView.spacing = Constants.verticalOffset
        stackView.distribution = .fill
        stackView.alignment = .leading
        
        stackView.addArrangedSubview(stockButton)
        stackView.addArrangedSubview(favouriteButton)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: Constants.stackViewTopOffset),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.tableViewOffset),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -Constants.tableViewOffset),
            stackView.heightAnchor.constraint(equalToConstant: Constants.stackViewHeight)
        ])
    }
    
    private func setUpStockButton() {
        
        stockButton.setTitle(Constants.stocksLabel, for: .normal)
        stockButton.titleLabel?.font = UIFont(name: Constants.boldFont, size: Constants.titleFontSize)
        stockButton.setTitleColor(.blackColor, for: .normal)
        
        stockButton.addTarget(self, action: #selector(stocksTapped), for: .touchUpInside)
    }
    
    private func setUpFavouriteButton() {
        
        favouriteButton.setTitle(Constants.favouriteLabel, for: .normal)
        favouriteButton.titleLabel?.font = UIFont(name: Constants.boldFont, size: Constants.boldFontSize)
        favouriteButton.setTitleColor(.grayTextColor, for: .normal)
        
        favouriteButton.addTarget(self, action: #selector(stocksTapped), for: .touchUpInside)
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
            tableView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: Constants.verticalOffset),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.horizontalOffset),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.horizontalOffset)
        ])
    }
    
    @objc func stocksTapped() {
        viewModel.changeButton()
        changeButtonAppereance()
        tableView.reloadData()
    }
    
    private func changeButtonAppereance() {
        
        if viewModel.isStocksSelected {
            stockButton.titleLabel?.font = UIFont(name: Constants.boldFont, size: Constants.titleFontSize)
            stockButton.setTitleColor(.blackColor, for: .normal)
            favouriteButton.titleLabel?.font = UIFont(name: Constants.boldFont, size: Constants.boldFontSize)
            favouriteButton.setTitleColor(.grayTextColor, for: .normal)
        } else {
            favouriteButton.titleLabel?.font = UIFont(name: Constants.boldFont, size: Constants.titleFontSize)
            favouriteButton.setTitleColor(.blackColor, for: .normal)
            stockButton.titleLabel?.font = UIFont(name: Constants.boldFont, size: Constants.boldFontSize)
            stockButton.setTitleColor(.grayTextColor, for: .normal)
        }
    }
}

extension StocksVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.filteredStocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? StocksCell else {
            return UITableViewCell()
        }
        let stock = viewModel.filteredStocks[indexPath.row]
        cell.createCell(stocksInfo: stock)
        cell.buttonAction = { [weak self] in
            if let stockId = stock.id {
                self?.viewModel.changeFavouriteStatus(id: stockId)
                self?.tableView.reloadData()
            }
        }
        return cell
    }
}
