//
//  ViewController.swift
//  CoredataTest
//
//  Created by Yuni on 2019/5/20.
//  Copyright © 2019 Yuni. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let metaInfo = ["id": 0,
                        "name": "test",
                        "email": "test@test.com"] as [String : AnyObject]
        
        CoreDataManager.shared.saveEntities(entityName: "User", metaInfo: metaInfo)
        
//        let predicate = String(format: "id = %@", "0")
        
//        CoreDataManager.shared.deleteEntity(entityName: "User", predicate: predicate)
        
//        CoreDataManager.shared.updateEntity(entityName: "User", predicate: predicate, metaInfo: metaInfo)
        
        if let users: [User] = CoreDataManager.shared.fetchEntities(entityName: "User", predicate: nil) as? [User] {
            for user in users {
                print(user.name ?? "")
                print(user.email ?? "")
                print(user.id)
            }
        }
    }
}

