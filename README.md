# updated_BulletTask_Repo
Bullet Task is a user-friendly Swift iOS app for daily task management, featuring a clean interface and intuitive task organization.

# BulletTask
Bullet Task is a user-friendly Swift iOS app for daily task management, featuring a clean interface and intuitive task organization.

Bullet Task is a versatile and intuitive Swift iOS app designed to enhance daily task management. With its clean and user-friendly interface, the app provides an efficient solution for organizing and tracking tasks seamlessly.

## Key Features
- Three Tab Views: The app offers three distinct tab views - Enter Task, TimeTable, and PureTask - providing different perspectives for managing tasks according to individual preferences.
- Task Entry: Users can effortlessly enter their tasks in the Enter Task view, allowing them to quickly capture and record their to-dos.
- Timetable View: The TimeTable view generates a visually appealing timetable with one-hour time blocks, automatically adjusting the start time based on the user's device settings. This feature provides a structured overview of the day, allowing users to allocate their tasks within specific time frames.
- PureTask View: The PureTask view displays a simple and focused task list without time frames. Users can easily view all their tasks at a glance, providing flexibility and freedom in task management.
- Task Completion Tracking: When users complete a task, they can simply tap on it in the PureTask view, instantly marking it as finished. The task block turns black, the text becomes white, and a strikethrough effect is applied, ensuring clear visibility of completed tasks.
- Synchronization: The app leverages advanced techniques such as @Published, @State, and @ObservableObject to ensure seamless synchronization between the PureTask view and the TimeTable view. When a task is marked as finished in one view, it automatically updates in the other, eliminating the need for manual synchronization.
- Data Persistence: Bullet Task utilizes plist for data persistence, ensuring that tasks remain intact even when the app is terminated in the background. Users can confidently rely on the app to retain their task data between sessions.
- Input Checker: The app includes an input checker to validate the appropriateness of task names, preventing users from entering invalid or empty task names.

With Bullet Task, users can experience a significant boost in productivity and efficiency by effectively managing their tasks and staying organized. The app provides a seamless and streamlined task management solution, simplifying daily routines and helping users stay on top of their responsibilities.
