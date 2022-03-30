//
//  CurrentUser.swift
//  MusicPlayer
//
//  Created by 罗俊豪 on 2021/5/4.
//

import Foundation
class CurrentUser{
    static var userName: String = "未登录"
    static var userEmail: String = "未登录"
    static var islogin: Bool = false
    static var userId: String = ""
    
    
    static func removeAll(){
        userName = "未登录"
        userEmail = "未登录"
        userId = ""
        islogin = false
    }
}
