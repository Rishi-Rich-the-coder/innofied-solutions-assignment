//
//  UserData.swift
//  InnofiedSolutionAssignment
//
//  Created by Rishikesh Yadav on 3/15/21.
//

import Foundation

 public struct UsersList: Decodable {
    let page: Int
    let per_page: Int
    let total: Int
    let total_pages: Int
    let data: [PersonDetails]
}


 public struct PersonDetails: Decodable {
    let id: Int
    let email: String
    let first_name: String
    let last_name: String
    // need to search for image
    let avatar: String
}
