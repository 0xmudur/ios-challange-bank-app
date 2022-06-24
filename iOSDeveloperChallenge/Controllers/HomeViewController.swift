//
//  HomeViewController.swift
//  iOSDeveloperChallenge
//
//  Created by Muhammed Emin Aydın on 17.06.2022.
//

import UIKit

let reachability = try! Reachability()

class HomeViewController: UIViewController {

    private let tableView: UITableView = UITableView()
    private let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    private let searchController: UISearchController = UISearchController()
    private var viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkNetworkReachability()
        setupActivityIndicator()
        setupTableView()
        setupViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupSearchBar()
    }
    
    private func checkNetworkReachability() {
        reachability.whenReachable = { reachability in
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
            } else {
                print("Reachable via Cellular")
            }
        }
        
        reachability.whenUnreachable = { _ in
            if reachability.connection == .wifi {
                print("Not Reachable")
                self.showAlert("Please check your connection")
            } else {
                print("Reachable via Cellular")
            }
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        
    }
    private func setupSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }
    
    private func setupViewModel() {
        
        viewModel.reloadTableView = {
            DispatchQueue.main.async { self.tableView.reloadData() ; self.tableView.isHidden = false }
        }
        
        viewModel.showActivityIndicator = {
            DispatchQueue.main.async { self.activityIndicator.startAnimating() ; self.activityIndicator.isHidden = false }
        }
        
        viewModel.hideActivityindicator = {
            DispatchQueue.main.async { self.activityIndicator.stopAnimating() ; self.activityIndicator.isHidden = true }
        }
        
        viewModel.getData()
    }
    
    private func setupActivityIndicator() {
        DispatchQueue.main.async {
            self.view.addSubview(self.activityIndicator)
            self.activityIndicator.center(inView: self.view)
            self.activityIndicator.style = .large
        }
    }
    
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func setupTableView(){
        view.addSubview(tableView)
        tableView.register(BankTableViewCell.self, forCellReuseIdentifier: BankTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.addConstraintsToFillView(view)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BankTableViewCell.identifier, for: indexPath) as! BankTableViewCell
        cell.model = viewModel.getCellViewModel( at: indexPath )
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let BankDetailViewController = BankDetailViewController(model: viewModel.bankDataList[indexPath.row])

        self.navigationController?.pushViewController(BankDetailViewController, animated: true)

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
}

extension HomeViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        
        let result = viewModel.bankDataList.filter({ searchText.contains( $0.dcBANKASUBE )})
        
        if !result.isEmpty {
            print("result: \(result)")
            viewModel.bankDataList = result
            viewModel.filterData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.getData()
    }
    
}

