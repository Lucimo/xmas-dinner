//
//  ParticipanteEntity.swift
//  Christmas Dinner
//
//  Created by LUCAS PAJARES PRIETO on 9/1/19.
//  Copyright © 2019 LUCAS PAJARES PRIETO. All rights reserved.
//

import UIKit
import RealmSwift
class ParticipantEntity: Object{
   @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var isMoroso = false
    @objc dynamic var date = Date()
    
    override static func primaryKey() -> String?{
        return "id"
    }
    convenience init (task : Participant){
        self.init()
        self.id = task.id
        self.name = task.name
        self.date = task.date
        self.isMoroso = task.isMoroso
    }
    
    func taskModel() -> Participant{
        let model = Participant()
        model.id = self.id
        model.date = self.date
        model.name = self.name
        model.isMoroso = self.isMoroso
        return model
        
    }
}
