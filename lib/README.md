# 📘 ToDoListApp

A clean and modern **Flutter To-Do List Application** built using **MVVM architecture**, **BLoC state management**, and **local database storage**.  
This app allows users to **create tasks**, **set reminders**, **apply filters**, and manage daily productivity with a smooth UI and offline support.

---

## 🚀 Features

### ✅ Core Features
- Add, edit, delete tasks
- Mark tasks as completed
- Set due dates & times

### ⏰ Reminder System
- Local notifications using `flutter_local_notifications`
- Background alarms with `android_alarm_manager_plus`
- Automatic permission handling

### 🎛 Filters & Sorting
- Sort by title, date, creation time, and more
- Apply filter combinations
- State handled through MVVM + BLoC

### 🎨 User Interface
- Staggered grid layout
- Responsive UI using `flutter_screenutil`
- Lottie animations
- Custom app launcher icons

### 💾 Offline Storage
- SQLite database using `sqflite`
- SharedPreferences for lightweight storage
- Repository pattern for clean data handling

---

## 🧱 Architecture: MVVM + BLoC

```
Model       → Task model, Reminder model, Filter model  
View        → Flutter UI (Screens & Widgets)  
ViewModel   → BLoC + Events + States  
Repository  → SQLite + SharedPreferences  
Services    → Notifications, Alarms, Utility Classes  
```

This architecture ensures testability, scalability, and maintainability.

---

## 📂 Project Structure

```
lib/
 ├─ core/
 │   ├─ routes/
 │   ├─ services/
 │   ├─ utils/
 │   └─ theme/
 ├─ features/
 │   ├─ home/
 │   │   ├─ model/
 │   │   ├─ view/
 │   │   └─ viewmodel/
 │   ├─ add_task/
 │   └─ reminder/
 ├─ shared/
 │   └─ widgets/
 └─ main.dart
```

---

## 📦 Dependencies

Your **pubspec.yaml** includes the following packages:

### UI & Layout
- `flutter_staggered_grid_view`
- `flutter_screenutil`
- `dropdown_button2`
- `lottie`
- `font_awesome_flutter`

### State Management
- `flutter_bloc`
- `equatable`
- `flutter_hooks`

### Data Storage
- `sqflite`
- `shared_preferences`
- `path_provider`

### Reminders & Notifications
- `flutter_local_notifications`
- `android_alarm_manager_plus`
- `permission_handler`

### Utility
- `get_it` (Dependency Injection)
- `url_launcher`
- `logger`

### Development
- `very_good_analysis`

### Icons
- `icons_launcher`

---


## 🔔 Reminder Workflow

1. User schedules a reminder
2. Alarm is set using `android_alarm_manager_plus`
3. Background callback triggers
4. Notification is shown using `flutter_local_notifications`

---