//
//  MainView.swift
//  BulletTask
//
//  Created by sam li  on 2022-12-26.
//


//import components
import SwiftUI
import Foundation

//Set the data
let today = Date()
// 2. Pick the date components
let hours   = (Calendar.current.component(.hour, from: today))
let minutes = (Calendar.current.component(.minute, from: today))

//Create a main view
struct MainView: View {
    
    //make a task model object (ObservableObject)
    @ObservedObject var model = TaskModel()
    
    //A text field text
    @State var textFieldText: String = ""
    
    
    //Set a state variable in the thing
    @State private var showMaxTaskError = false
    
    @State var mainButtonString = "ENTER"
    
    @State var currFocusTask:Int = 0;
    
    //Initialize local hours
    var local_hours = 0
    
    
    var body: some View {
        
        
        //MARK: Tab View Start here
        
        //here is the tab view
        TabView
        {
            
            //MARK: Enter View
            //Inside the V stack
            VStack(spacing: 0) {
                        Spacer()
                        
                        VStack {
                            
                            Button(action: {
                                //Call the clear all function
                                clearAll()
                            }) {
                                //Style and shit
                                Text("Delete all Task".uppercased())
                                    .padding(.all)
                                    .frame(maxWidth: .infinity)
                                    .background((model.tasks.count >= 1) ? Color.black : Color.gray)
                                    .cornerRadius(20)
                                    .foregroundColor(.white)
                                    .font(.headline)
                                    .padding(.leading)
                                    .padding(.trailing)
                            }
                            .disabled(!(model.tasks.count >= 1))
                            
                            //A text field that prompts the user to input text
                            TextField("Type your task here...", text: $textFieldText)
                                .padding(.all)
                                .background(Color.gray.opacity(0.3).cornerRadius(20))
                                .foregroundColor(.black)
                                .font(.headline)
                                .padding(.leading)
                                .padding(.trailing)
                            
                            //The button here is button here
                            Button(action: {
                                //When clicked, check those things
                                if textIsAppropriate() && (mainButtonString == "ENTER"){
                                    saveText()
                                } else if textIsAppropriate() && (mainButtonString == "UPDATE"){
                                    updateText(taskIndex: currFocusTask)
                                }else {
                                    //or make the text field empty
                                    textFieldText = ""
                                }
                            }) {
                                Text(mainButtonString.uppercased())
                                    .padding(.all)
                                    .frame(maxWidth: .infinity)
                                    .background(Color.black)
                                    .cornerRadius(20)
                                    .foregroundColor(.white)
                                    .font(.headline)
                                    .padding(.leading)
                                    .padding(.trailing)
                            }
                        }
                        .position(x: UIScreen.main.bounds.width / 2, y: 0.135 * UIScreen.main.bounds.height) // Adjust the vertical position as needed
                
                        if model.tasks.count >= 1 {
                            //List the text
                            VStack {
                                List {
                                    ForEach(0..<model.tasks.count, id: \.self) { index in
                                        let localString: String = model.tasks[index].content
                                        
                                        HStack {
                                            Text(localString)
                                            
                                            Spacer()
                                            
                                            VStack {
                                                Button(action: {
                                                    // Set the currFocusTask to the index
                                                    currFocusTask = index
                                                    
                                                    // Change mainButtonString into "UPDATE"
                                                    mainButtonString = "UPDATE"
                                                    
                                                    // Load the text of the current string / localString into the text field
                                                    textFieldText = model.tasks[index].content
                                                    
                                                    // Pop up the keyboard on the iPhone
                                                    UIApplication.shared.sendAction(#selector(UIResponder.becomeFirstResponder), to: nil, from: nil, for: nil)
                                                }) {
                                                    Text("EDIT")
                                                        .padding(.vertical, 8)
                                                        .padding(.horizontal, 10)
                                                        .foregroundColor(.white)
                                                        .background(Color.black)
                                                        .clipShape(Capsule())
                                                        .font(.headline)
                                                }
                                                .buttonStyle(PlainButtonStyle()) // Add this line to remove the button flashing effect
                                            }
                                            .frame(width: 60) // Adjust the width of the VStack to contain only the button
                                            
                                            Divider()
                                                .frame(height: 20) // Adjust the height of the divider to provide spacing
                                            
                                            VStack {
                                                Button(action: {
                                                    currFocusTask = index
                                                    deleteTask(taskIndex: index)
                                                }) {
                                                    Text("DELETE")
                                                        .padding(.vertical, 8)
                                                        .padding(.horizontal, 5)
                                                        .foregroundColor(.white)
                                                        .background(Color.black)
                                                        .clipShape(Capsule())
                                                        .font(.headline)
                                                }
                                                .buttonStyle(PlainButtonStyle()) // Add this line to remove the button flashing effect
                                            }
                                            .frame(width: 80) // Adjust the width of the VStack to contain only the button
                                        }
                                    }
                                }

                                .listStyle(InsetGroupedListStyle())
                                .padding(.top, -100)
                                
                            }
                        }
                    }
                    .tabItem {
                        VStack {
                            //The tab's view
                            Text("Enter Task")
                        }
                    }
            
            .sheet(isPresented: $showMaxTaskError) {
                ErrorView(errorMessage: "Your task list has reached 24:00 pm. Delete some tasks to add more.")
            }
            
            //MARK: Time Table View
            VStack
            {
                
                //Get the local hours
                var local_hours:Int = hours
                
                //If there is nmore than 1 text
                if model.tasks.count >= 1
                {
                    //List the things
                    List
                    {
                        
                        //For each things in the model's task property
                        ForEach(0...model.tasks.count-1, id: \.self)
                        {
                            index in
                            
                            
                            //Start time is the index + local hour
                            let startTime:String = (String(index + local_hours + 1) + ":00")
                            let endTime:String = (String(index + local_hours + 2) + ":00")
                            
                            //Local time fram representing index
                            let localTimeFram:String = (startTime + " - " + endTime)
                            
                            //Local String is the index
                            let localString:String = model.tasks[index].content
                            
                            //If this is not finished
                            if !(model.tasks[index].finished)
                            {
                                //Make a button, and its lable
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
                            //Else if it is finished
                            else if model.tasks[index].finished
                            {
                                Button{
                                    model.changeFinishedState(index: index)
                                } label: {
                                    VStack(alignment: .leading)
                                    {
                                        Text(localTimeFram)
                                        Text(localString)
                                    }
                                    .foregroundColor(.white)
                                    .strikethrough(true, color: .white)
                                }.listRowBackground(Color.black)
                            }
                            
                        }
                    }
                    
                }
                //This is a tabItem
            }.tabItem{
                VStack
                {
                    //TimeTableView
                    Text("Time Table")
                }
            }
            
            //MARK: Pure Task View
            VStack
            {
                
                //Same, but without the time span
                if model.tasks.count >= 1
                {
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
                                    }
                                    .foregroundColor(.white)
                                    .strikethrough(true, color: .white)
                                }.listRowBackground(Color.black)
                            }
                            
                        }
                    }
                }
            }.tabItem{
                VStack
                {
                    Text("Pure Task")
                }
            }
            
            
        }
        .foregroundColor(Color.black)
        .onAppear
        {
            // Call the loadTask() function when the view appears
            loadTask()
        }
        
    }
    
    //Make sure if it is appropriate333
    
    
    func textIsAppropriate() -> Bool
    {
        if (textFieldText.count <= 1)
        {
            return false
        }
        
        if (hours + model.tasks.count >= 23)
        {
            showMaxTaskError = true
            return false
        }
        
        return true
    }
    
    func deleteTask(taskIndex: Int)
    {
        model.removeElement(at: taskIndex)
        
        // Create a new PropertyListEncoder instance
        let encoder = PropertyListEncoder()
        
        // Set the output format of the encoder to XML
        encoder.outputFormat = .xml
        
        // Encode the tasks array to Property List format
        let plistData = try! encoder.encode(model.tasks)
        
        // Get the URL to the app's documents directory and append "tasks.plist" to it
        let plistURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("tasks.plist")
        
        // Write the encoded data to the tasks.plist file
        try! plistData.write(to: plistURL)
        
    }
    
    func updateText(taskIndex: Int)
    {
        model.tasks[taskIndex].content = textFieldText
        
        mainButtonString = "ENTER"
        
        textFieldText = ""
        
        // Create a new PropertyListEncoder instance
        let encoder = PropertyListEncoder()
        
        // Set the output format of the encoder to XML
        encoder.outputFormat = .xml
        
        // Encode the tasks array to Property List format
        let plistData = try! encoder.encode(model.tasks)
        
        // Get the URL to the app's documents directory and append "tasks.plist" to it
        let plistURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("tasks.plist")
        
        // Write the encoded data to the tasks.plist file
        try! plistData.write(to: plistURL)
        
        
    }
    
    
    func saveText()
    {
        //Add the task to the model task array list, and set the textFieldText as the content and set finish as false
        model.tasks.append(Task(content: textFieldText, finished: false))
        //Set the textField text equals to empty
        textFieldText = ""
        
        // Create a new PropertyListEncoder instance
        let encoder = PropertyListEncoder()
        
        // Set the output format of the encoder to XML
        encoder.outputFormat = .xml
        
        // Encode the tasks array to Property List format
        let plistData = try! encoder.encode(model.tasks)
        
        // Get the URL to the app's documents directory and append "tasks.plist" to it
        let plistURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("tasks.plist")
        
        // Write the encoded data to the tasks.plist file
        try! plistData.write(to: plistURL)
    }
    
    func clearAll()
    {
        //model renmove all element
        model.removeAllEle()
        //Set the TextField to empty
        textFieldText = ""
        
        // Clear the Property List file
        let plistURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("tasks.plist")
        if FileManager.default.fileExists(atPath: plistURL.path) {
            try! FileManager.default.removeItem(at: plistURL)
        }
        
        
    }
    
    func loadTask()
    {
        // Get the URL to the tasks.plist file
        let plistURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("tasks.plist")
        
        // Check if the file exists
        if !FileManager.default.fileExists(atPath: plistURL.path) {
            
            // Create a new PropertyListEncoder instance
            let encoder = PropertyListEncoder()
            
            // Set the output format of the encoder to XML
            encoder.outputFormat = .xml
            
            // Encode the empty tasks array to Property List format
            let plistData = try! encoder.encode(model.tasks)
            
            // Write the encoded data to the tasks.plist file
            try! plistData.write(to: plistURL)
        }
        
        // Read the contents of the tasks.plist file into a Data object
        let plistData = try! Data(contentsOf: plistURL)
        
        // Create a new PropertyListDecoder instance
        let decoder = PropertyListDecoder()
        
        // Decode the data from the Property List format to an array of Task objects
        model.tasks = try! decoder.decode([Task].self, from: plistData)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
