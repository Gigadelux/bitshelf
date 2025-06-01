# 📚 Bitshelf

A cross-platform **Flutter** application to manage your personal library of books with full **CRUD** functionality.
Built using **Flutter 3.x** and a clean **MVC (Model-View-Controller)** architecture.

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

## 🧠 Architecture – MVC Pattern

```bash
lib/
├── main.dart                # Entry point
├── controllers/             # Controllers (business logic, state management)
├── core/                    # App configuration and core utilities
├── data/                    # Data models, gateways, repositories
│   ├── models/              # Data classes (e.g., Book)
│   ├── gateway/             # Data access (local, remote, fake)
│   └── repository/          # Abstracted data storage logic
├── services/                # Business logic and data operations
│   ├── auth/                # Authentication services
│   ├── encryption/          # Encryption utilities
│   └── Filter/              # Filtering and search logic
├── view/                    # UI screens, widgets, and assets
│   ├── ui/                  # UI widgets and pages
│   ├── presenter/           # Presentation logic (if any)
│   └── assets/              # Images and fonts
```

---

Designed to be modular, scalable, and maintainable — perfect for growing your personal library digitally with style.
