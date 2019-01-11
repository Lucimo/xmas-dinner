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
   @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var isMoroso = false
    @objc dynamic var date = Date()
    
    override static func primaryKey() -> String?{
        return "id"
    }
    convenience init (participant : Participant){
        self.init()
        self.id = participant.id!
        self.name = participant.name
        self.date = participant.date
        self.isMoroso = participant.isMoroso
    }
    
    func participantModel() -> Participant{
        let model = Participant()
        model.id = self.id
        model.date = self.date
        model.name = self.name
        model.isMoroso = self.isMoroso
        return model
        
    }
}
