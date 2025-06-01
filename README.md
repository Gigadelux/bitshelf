# 📚 Bitshelf

A cross-platform **Flutter** application to manage your personal library of books with full **CRUD** functionality.
Built using **Flutter 3.x** and the clean **MVVM (Model-View-ViewModel)** architecture.

---

## ✨ Features

* 📝 Add new books to your personal collection
* 📖 View detailed book information
* ✏️ Edit existing book entries
* ❌ Delete books you no longer want
* 💾 Persistent local storage using **Hive**, **SQLite**, or **SharedPreferences**
* 🎨 Responsive and modern **Material Design** UI
* 🖥️ Built with **Flutter**, targeting desktop, web, and mobile platforms

---

## 🧠 Architecture – MVVM Pattern

```bash
lib/
├── main.dart               # Entry point
├── models/                # Data classes (e.g., Book)
├── views/                 # UI screens and widgets
├── viewmodels/            # State management logic (e.g., using Provider, Riverpod, or BLoC)
├── services/              # Business logic and data operations
├── repositories/          # Abstracted data storage logic (e.g., database handlers)
└── utils/                 # Utility functions and constants
```

---

Designed to be modular, scalable, and maintainable — perfect for growing your personal library digitally with style.
