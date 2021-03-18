//
//  HomeViewModel.swift
//  InnofiedSolutionAssignment
//
//  Created by Rishikesh Yadav on 3/15/21.
//

import Foundation

class HomeViewModel {
    
    let networkUsecase: NetworkUsecaseType!
    var userList: UsersList?
    var indexPathsForNewList = Observable<[IndexPath]?>(nil)
    var usersTableViewDataSource = [PersonDetails]()
    var currentPage = 0
    var isFetchInProgress = false
    
    init() {
        networkUsecase = NetworkUsecase()
    }
    
    func getUserData() {
        if isFetchInProgress { return }
        currentPage += 1
        isFetchInProgress = true
        
        networkUsecase.getUserData(pageNumber: currentPage) { [unowned self] userListFromApi in
            if let usersList = userListFromApi {
                self.usersTableViewDataSource.append(contentsOf: usersList.data)
                self.userList = usersList
                self.isFetchInProgress = false
                
                if currentPage > 1 {
                    self.indexPathsForNewList.value = getIndexPaths(for: usersList.data)
                } else {
                    self.indexPathsForNewList.value = nil
                }
            }
        }
    }
    
    func getIndexPaths(for newUserList: [PersonDetails]) -> [IndexPath] {
        let firstIndex = usersTableViewDataSource.count - newUserList.count
        let lastIndex = firstIndex + newUserList.count
        return (firstIndex..<lastIndex).map { IndexPath(row: $0, section: 0) }
    }
    
}




extension HomeViewModel {
    
    func testWithHardcodedData() {
        currentPage += 1
        let person = PersonDetails(id: 1, email: "one@twoc.com", first_name: "name", last_name: "surname", avatar: "")
        let totalPersonList = Array(repeating: person, count: 30)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {
            
            let usersList = UsersList(page: self.currentPage, per_page: 30, total: 90, total_pages: 3, data: totalPersonList)
            self.usersTableViewDataSource.append(contentsOf: totalPersonList)
            self.userList = usersList
            
            if self.currentPage > 1 {
                self.indexPathsForNewList.value = self.getIndexPaths(for: usersList.data)
            } else {
                self.indexPathsForNewList.value = nil
            }
        })
    }
}
