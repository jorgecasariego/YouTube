//
//  Video.swift
//  youtube
//
//  Created by Jorge Casariego on 29/8/16.
//  Copyright © 2016 Jorge Casariego. All rights reserved.
//

import UIKit

class SafeJsonObject: NSObject {
    
    // Para que esto funcione el json y el nombre de las variables de nuestro Objeto deben ser iguales. Si ambos son iguales entonces automaticamente los valores del json se cargaran en el objeto.
    // En el caso de Channel llamamos a setValuesForKeysWithDictionary pasandole el value y este a su vez automaticamente va a cargar todos los valores en el objeto channel.
    // ¿Que pasa si se agrega un nuevo campo en el json? Para eso debemos hacer un pequeño truco. El metodo setValue llama automaticamente al set del atributo que encuentre en el json. Si el atributo existe funciona perfectamente, si no existe el atributo en nuestro objeto explota. Solucion: crear un valor del tipo "setValor" donde "Valor" es el nombre del atributo y al obtener ese valor tratamos de llamar. Si retorna true entonces significa que ese atributo existe en nuestro objeto, si es false quiere decir que no existe. Por lo que si nos devuelve false entonces hacemos un return y ya no tendria que fallar.
    override func setValue(value: AnyObject?, forKey key: String) {
        
        // Convertimos la primera letra a Mayuscula
        let uppercaseFirstCharacter = String(key.characters.first!).uppercaseString
        
        // Reemplazamos la primera letra de la palabra de minuscula a mayuscula
        let range = key.startIndex...key.startIndex.advancedBy(0)
        let selectorString = key.stringByReplacingCharactersInRange(range, withString: uppercaseFirstCharacter)
        
        
        // Creamos el string que luego sera llamado para ver si existe el metodo set"Selector"
        let selector = NSSelectorFromString("set\(selectorString):")
        
        // Vemos si existe el metodo
        let responds = self.respondsToSelector(selector)
        
        
        // Si no existe retornamos
        if !responds {
            return
        }
        
        
        super.setValue(value, forKey: key)
    }
}

class Video: SafeJsonObject {
    
    var thumbnail_image_name: String?
    var title: String?
    var number_of_views: NSNumber?
    var uploadDate: NSDate?
    var duration: NSNumber?
    
    var channel: Channel?
    
    override func setValue(value: AnyObject?, forKey key: String) {
        if key == "channel" {
            self.channel = Channel()
            self.channel?.setValuesForKeysWithDictionary(value as! [String: AnyObject])
        } else {
            super.setValue(value, forKey: key)
        }
    }
    
    init(dictionary: [String: AnyObject]) {
        super.init()
        
        setValuesForKeysWithDictionary(dictionary)
    }
}

class Channel: SafeJsonObject {
    var name: String?
    var profile_image_name: String?
    
}
