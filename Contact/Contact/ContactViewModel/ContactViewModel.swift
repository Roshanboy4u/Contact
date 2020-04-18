//
//  ContactViewModel.swift
//  Contact
//
//  Created by Roshan sah on 01/04/20.
//  Copyright © 2020 Roshan sah. All rights reserved.
//

import Foundation

class MountainsController {
    
    func filteredMountains(with filter: String?=nil, limit: Int?=nil) -> [Mountain] {
        let filtered = mountains.filter { $0.contains(filter) }
        if let limit = limit {
            return Array(filtered.prefix(through: limit))
        } else {
            return filtered
        }
    }
    
    private lazy var mountains: [Mountain] = {
        return generateMountains()
    }()
}

extension MountainsController {
    private func generateMountains() -> [Mountain] {
        let components = mountainsRawData.components(separatedBy: CharacterSet.newlines)
        var mountains = [Mountain]()
        for line in components {
            let mountainComponents = line.components(separatedBy: ",")
            let name = mountainComponents[0]
            let height = Int(mountainComponents[1])
            mountains.append(Mountain(name: name, height: height!))
        }
        return mountains
    }
}
