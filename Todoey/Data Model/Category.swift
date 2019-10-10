//
//  Category.swift
//  Todoey
//
//  Created by Gary Naz on 10/5/19.
//  Copyright © 2019 Gari Nazarian. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
}
