//
//  Task.swift
//  BulletTask
//
//  Created by sam li  on 2022-12-26.
//

import Foundation

class Task: Identifiable, Codable {
    // properties
    var id: UUID
    var content: String
    var finished: Bool
    
    // initializer
    init(id: UUID = UUID(), content: String, finished: Bool) {
        self.id = id
        self.content = content
        self.finished = finished
    }
}

