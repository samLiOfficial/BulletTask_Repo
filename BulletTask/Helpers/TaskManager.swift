//
//  TaskManager.swift
//  BulletTask
//
//  Created by sam li  on 2023-05-04.
//
import Foundation

class TaskManager: ObservableObject {
    @Published var tasks = [Task]()
    
    func addTask(_ task: Task) {
        tasks.append(task)
    }
    
    func removeTask(at index: Int) {
        tasks.remove(at: index)
    }
    
    func removeAllTasks() {
        tasks.removeAll()
    }
    
    func toggleTaskCompletion(at index: Int) {
        tasks[index].finished.toggle()
    }
    
    func isTaskFinished(at index: Int) -> Bool {
        return tasks[index].finished
    }
}

