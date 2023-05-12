//
//  TaskModel.swift
//  BulletTask
//
//  Created by sam li  on 2022-12-26.
//

import Foundation

class TaskModel: ObservableObject
{
    //Have a published property, which is a array of task
    @Published public var tasks = [Task]()
    
    init()
    {
        //create a instance of the data service and get th data
        
        //I acc dont know WTF
        self.tasks = DataService.getLocalData()
    }
    
    
    //Change the finished state
    func changeFinishedState(index:Int)
    {
        self.tasks[index].finished.toggle()
        self.tasks.append(self.tasks.remove(at: index))
    }
    
    //Remove all thing from the task property
    func removeAllEle()
    {
        self.tasks.removeAll()
    }
    
    // Remove an element at a specific index
        func removeElement(at index: Int) {
            guard index >= 0 && index < tasks.count else {
                return // Index out of range, do nothing
            }
            
            tasks.remove(at: index)
        }
    
}
