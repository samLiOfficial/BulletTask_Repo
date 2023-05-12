//
//  DataService.swift
//  BulletTask
//
//  Created by sam li  on 2022-12-26.
//

import Foundation

class DataService
{
    static func getLocalData() -> [Task]
    {
        //Parse local json file
        
        //Get a URL path to the json file
        
        let pathString = Bundle.main.path(forResource: "sampleData", ofType: "json")
        
        //check if pathString is not nil
        guard pathString != nil else
        {
            return [Task]()
        }
        
        //Create a URL Object
        
        let url = URL(fileURLWithPath: pathString!)
        
        //catch error when creating the data
        do
        {
            let data = try Data(contentsOf: url)
            
            //Decode the data with the JSON decoder
            
            let decoder = JSONDecoder()
            
            
            do
            {
                let taskData = try decoder.decode([Task].self, from: data)
                
                //Add unique ids
                
                for curr_task in taskData
                {
                    curr_task.id = UUID()
                }
                
                //return the tasks
                return taskData
                
            }
            catch
            {
                print(error)
            }
            
            
        }
        catch
        {
            print(error )
        }
        
        //Create a data Object
        
       return [Task]()
        
  
    }
}
