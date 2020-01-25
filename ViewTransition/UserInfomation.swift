//
//  UserInfomation.swift
//  ViewTransition
//
//  Created by Misun Joo on 25/01/2020.
//  Copyright © 2020 Misun Joo. All rights reserved.
//

// swift file

import Foundation

class UserInformation {
    // 타입 프로퍼티가 뭘까?
    static let shared: UserInformation = UserInformation()
    
    var name: String?
    var age: String?
}
