//
//  AirticleListViewController.swift
//  NYTimesAirticles
//
//  Created by Karunanithi on 24/07/19.
//  Copyright © 2019 Karunanithi All rights reserved.
//

import UIKit

class AirticleListViewController: UIViewController {
    
    var viewModel: AirticleListViewModel {
        return controller.viewModel
    }
    
    lazy var controller: AirticleListController = {
        return AirticleListController()
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        NSLayoutConstraint.activate(tableView.edgeConstraints(top: 80, left: 0, bottom: 0, right: 0))
        
        tableView.register(AirticleCell.self, forCellReuseIdentifier: AirticleCell.cellIdentifier())
        return tableView
    }()
    
    lazy var loadingIdicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .gray)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        self.view.addSubview(indicator)
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            ])
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initBinding()
        controller.start()
        self.title = "NY Times Most Popular"
    }
    
    func initView() {
        view.backgroundColor = .white
    }
    
    func initBinding() {
        
        
        viewModel.isTableViewHidden.addObserver { [weak self] (isHidden) in
            self?.tableView.isHidden = isHidden
        }
        
        viewModel.isLoading.addObserver { [weak self] (isLoading) in
            if isLoading {
                self?.loadingIdicator.startAnimating()
            } else {
                self?.loadingIdicator.stopAnimating()
            }
        }
        
        viewModel.rowViewModels.addObserver(fireNow: false) { [weak self] (viewModels) in
            self?.tableView.reloadData()
        }
        
        viewModel.errorMsg.addObserver(fireNow: false) { [weak self] (errorMsg) in
            self?.showAlert(errorMsg)
        }
    }
    
    // MARK: - Show alert controller
    func showAlert(_ message: String) {
        let alertController = UIAlertController(title: "Sorry",
                                                message: message,
                                                preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel,
                                         handler: nil)
        let retryAction = UIAlertAction(title: "Retry",
                                        style: .default) { (_) in
                                            self.controller.start()
        }
        alertController.addAction(cancelAction)
        alertController.addAction(retryAction)
        present(alertController,
                animated: true,
                completion: nil)
    }
    
}

extension AirticleListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rowViewModels.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rowViewModel = viewModel.rowViewModels.value[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: AirticleCell.cellIdentifier(), for: indexPath)
        if let cell = cell as? CellConfigurable {
            cell.setup(viewModel: rowViewModel)
        }
        
        cell.accessibilityIdentifier = "AirticleCell\(indexPath.row)"
        cell.accessoryType = .disclosureIndicator
        cell.layoutIfNeeded()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rowViewModel = viewModel.rowViewModels.value[indexPath.row]
        let detailsVC = AirticleDetailsViewController()
        detailsVC.rowViewModel = rowViewModel
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
