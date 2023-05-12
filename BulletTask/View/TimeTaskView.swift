//
//  TimeTaskView.swift
//  BulletTask
//
//  Created by sam li  on 2022-12-26.
//

import SwiftUI

struct TimeTaskView: View {
    
    
    @ObservedObject var model = TaskModel()
    
    var startSetTime = 8
    
    var body: some View {
        
        let startSetTime = 8
        
        List
        {
            
            ForEach(0...model.tasks.count-1, id: \.self)
            {
                index in
                
                let startTime:String = (String(index + startSetTime) + ":00")
                let endTime:String = (String(index + startSetTime + 1) + ":00")
                
                let localTimeFram:String = (startTime + " - " + endTime)
                
                let localString:String = model.tasks[index].content
                
                if !(model.tasks[index].finished)
                {
                    Button{
                        model.changeFinishedState(index: index)
                    } label: {
                        VStack(alignment: .leading)
                        {
                            Text(localTimeFram)
                            Text(localString)
                        }.foregroundColor(.black)
                    }
                }
                else if model.tasks[index].finished
                {
                    Button{
                        model.changeFinishedState(index: index)
                    } label: {
                        VStack(alignment: .leading)
                        {
                            Text(localTimeFram)
                            Text(localString)
                        }.foregroundColor(.black)
                    }.listRowBackground(Color.black)
                }
              
            }
        }
    }
}

struct TimeTaskView_Previews: PreviewProvider {
    static var previews: some View {
        TimeTaskView()
    }
}
