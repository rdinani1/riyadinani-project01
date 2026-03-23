# 📱 Habit Mastery League

## 📖 Project Description
Habit Mastery League is an offline-first mobile application built using Flutter and Dart. It is designed to help students track their daily habits, stay consistent, and improve productivity. Unlike many habit-tracking apps, this application works completely offline using local storage, making it reliable and accessible at all times.

---

## 👤 Team Members
- Riya Dinani

---

## ✨ Features
- Add new habits with title, description, and category  
- View all habits in a clean and organized list  
- Edit existing habits  
- Delete habits with confirmation dialog  
- Mark habits as completed or not completed  
- View habit statistics (total, completed, incomplete, completion rate)  
- Dark mode toggle using settings  
- Save and display username  
- Pull-to-refresh habit list  
- Improved empty state UI  

---

## 🛠️ Technologies Used
- Flutter (UI Framework)  
- Dart (Programming Language)  
- SQLite (sqflite package for local database)  
- SharedPreferences (for storing user settings)  
- Git & GitHub (version control)  

---

## ⚙️ Installation Instructions

1. Clone the repository:
```bash
git clone https://github.com/rdinani1/riyadinani-project01.git


---

## 📱 Usage Guide
1. Launch the app  
2. Add a new habit using the "+" button  
3. View all habits in the list  
4. Tap a habit to view details  
5. Edit or delete habits  
6. Mark habits as completed  
7. View statistics in the Stats screen  
8. Customize settings (username and dark mode)  

---

## 🗄️ Database Schema

### Habits Table:
- id (INTEGER, PRIMARY KEY)  
- title (TEXT)  
- description (TEXT)  
- category (TEXT)  
- createdAt (TEXT)  
- isCompleted (INTEGER / BOOLEAN)  

---

## ⚠️ Known Issues
- No cloud synchronization (offline only)  
- No notification/reminder system implemented  
- Basic statistics only (no charts yet)  

---

## 🚀 Future Enhancements
- Add habit reminders and notifications  
- Implement habit streak tracking  
- Add charts and visual analytics  
- Cloud backup support  
- More UI customization options  

---

## 📄 License
MIT License