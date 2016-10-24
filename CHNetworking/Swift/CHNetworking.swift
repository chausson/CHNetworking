//
//  CHNetworking.swift
//  CHNetworkingDemo
//
//  Created by Chausson on 16/10/24.
//  Copyright © 2016年 CM. All rights reserved.
//

import Foundation

public protocol CHNetRequest {
    var URLPath:String{ get }
    var parm:[String :Any]{ get }
    func request()
    
}

struct CHNetWorking {
    
}