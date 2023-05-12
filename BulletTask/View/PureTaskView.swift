//
//  PureTaskView.swift
//  BulletTask
//
//  Created by sam li  on 2022-12-26.
//

import SwiftUI

struct PureTaskView: View {
    
    //reference the view model
    @ObservedObject var model = TaskModel()
    
    var body: some View {
       
        List
        {
            
            ForEach(0...model.tasks.count-1, id: \.self)
            {
                index in
                
                let localString:String = model.tasks[index].content
                
                if !(model.tasks[index].finished)
                {
                    Button{
                        model.changeFinishedState(index: index)
                    } label: {
                        VStack(alignment: .leading)
                        {
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
                            Text(localString)
                        }.foregroundColor(.black)
                    }.listRowBackground(Color.black)
                }
              
            }
        }

    }
}

struct PureTaskView_Previews: PreviewProvider {
    static var previews: some View {
        PureTaskView()
    }
}
