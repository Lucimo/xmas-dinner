//
//  Participante.swift
//  Christmas Dinner
//
//  Created by LUCAS PAJARES PRIETO on 9/1/19.
//  Copyright © 2019 LUCAS PAJARES PRIETO. All rights reserved.
//

import Foundation
class Recipes{
    var nombre: String?
    var fecha: Date?
    var id:Int?
    var isMoroso: Bool?
    init(nombre: String?, fecha: Date?, id:Int?, isMoroso: Bool?) {
        self.nombre = nombre
        self.fecha = fecha
        self.id = id
        self.isMoroso = isMoroso
    
    }
}
