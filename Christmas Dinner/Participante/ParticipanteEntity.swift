//
//  ParticipanteEntity.swift
//  Christmas Dinner
//
//  Created by LUCAS PAJARES PRIETO on 9/1/19.
//  Copyright © 2019 LUCAS PAJARES PRIETO. All rights reserved.
//

import UIKit
import RealmSwift
class ParticipanteEntity: Object{
   @objc dynamic var id = ""
    @objc dynamic var nombre = ""
    @objc dynamic var isMoroso = false
    @objc dynamic var fecha = Date()
    
    override static func primaryKey() -> String?{
        return "id"
    }
    convenience init (task : Parcipante){
        self.init()
        self.id = task.id
        self.nombre = task.nombre
        self.fecha = task.fecha
        self.isMoroso = task.isMoroso
    }
    func taskModel() -> Participante{
        let model = Participante()
        model.id = self.id
        model.fecha = self.fecha
        model.nombre = self.nombre
        model.isMoroso = self.isMoroso
        return model
        
    }
}
