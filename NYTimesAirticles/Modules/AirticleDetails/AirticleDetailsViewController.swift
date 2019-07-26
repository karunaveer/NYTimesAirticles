//
//  AirticleDetailsViewController.swift
//  NYTimesAirticles
//
//  Created by Karunanithi on 24/07/19.
//  Copyright © 2019 Karunanithi All rights reserved.
//

import UIKit

class AirticleDetailsViewController: UIViewController {
    private var tableView: UITableView!
    var rowViewModel : RowViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        // Do any additional setup after loading the view.
    }
    func setupTableView() {
        tableView = UITableView(frame: view.frame)
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "AirticleDetails", bundle: nil), forCellReuseIdentifier: "AirticleDetails")
        tableView.dataSource = self
        view.addSubview(tableView)
    }
}
// MARK: - UITableViewDataSource
extension AirticleDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let detailsCell = tableView.dequeueReusableCell(withIdentifier: "AirticleDetails", for: indexPath)
        if let detailsCell = detailsCell as? CellConfigurable, let rowViewModel = self.rowViewModel {
            detailsCell.setup(viewModel: rowViewModel)
        }
        return detailsCell
    }
}
