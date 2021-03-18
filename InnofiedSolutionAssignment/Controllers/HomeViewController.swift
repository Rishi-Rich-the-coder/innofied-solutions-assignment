//
//  HomeViewController.swift
//  InnofiedSolutionAssignment
//
//  Created by Rishikesh Yadav on 3/15/21.
//

import UIKit
import Foundation


class HomeViewController: UIViewController {
    
    var viewModel: HomeViewModel!
    @IBOutlet weak var usersListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeViewModel()
        setupObservable()
        // This function calls the api, as the number of data is too small, you can test this using hard-coded data
        
        //viewModel.getUserData()
       
        // Hard-coded data for testing.
        viewModel.testWithHardcodedData()
    }
    
    func setupObservable() {
        viewModel.indexPathsForNewList.bind(to: {[unowned self] (newIndices) in
            DispatchQueue.main.async {
                guard let newIndexList = newIndices  else {
                    self.usersListTableView.reloadData()
                    return
                }
                
                let newIndexToReload = visibleIndexPathsToReload(intersecting: newIndexList)
                self.usersListTableView.reloadRows(at: newIndexToReload, with: .automatic)
            }
        })
    }
}


extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.userList?.total ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserDataTableViewCell", for: indexPath) as? UserDataTableViewCell else { return UITableViewCell() }
        
        if isLoadingCell(for: indexPath) {
            cell.setupCell(with: nil)
        } else {
            let userData = viewModel.usersTableViewDataSource[indexPath.row]
            cell.setupCell(with: userData)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.00
    }
}

extension HomeViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            //viewModel.getUserData()
           viewModel.testWithHardcodedData()
        }
    }
}

extension HomeViewController {
    
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= viewModel.usersTableViewDataSource.count
    }
    
    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = usersListTableView.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
}
