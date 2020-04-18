//
//  ContactModel.swift
//  Contact
//
//  Created by Roshan sah on 01/04/20.
//  Copyright © 2020 Roshan sah. All rights reserved.
//

import Foundation

struct Mountain {
    let name: String
    let height: Int
    let identifier = UUID()
    
}

extension Mountain: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: Mountain, rhs: Mountain) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

extension Mountain {
    func contains(_ filter: String?) -> Bool {
        guard let filterText = filter else { return true }
        if filterText.isEmpty { return true }
        let lowercasedFilter = filterText.lowercased()
        return name.lowercased().contains(lowercasedFilter)
    }
}
