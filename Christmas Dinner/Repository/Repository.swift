//
//  Repository.swift
//  Christmas Dinner
//
//  Created by LUCAS PAJARES PRIETO on 11/1/19.
//  Copyright © 2019 LUCAS PAJARES PRIETO. All rights reserved.
//

import Foundation
protocol Repository {
    associatedtype T
    
    func getAll() -> [T]
    func get(identifier:String) -> T?
    func get(name:String) -> T?
    func create(a:T) -> Bool
    func delete(a:T) -> Bool
    func update(a:T) -> Bool
}
