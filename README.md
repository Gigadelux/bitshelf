# 📚 Bitshelf

Bitshelf is a cross-platform **Flutter** application for managing your personal or shared library, designed with a robust **MVC(-ish)** architecture and built to be extensible, secure, and user-friendly.

---

## ✨ Main Features

* 📝 Add new books to your collection
* 📖 View and filter books with powerful search tools
* ✏️ Edit and update book information
* ❌ Delete books you no longer need
* 🔍 Filter and sort books by title, author, genre, review, and status
* 🔄 Import and export your library in **CSV** format (with permission and encryption support)
* 🔐 User management and optional data encryption
* 🖥️ Modern, responsive interface optimized for desktop, web, and mobile
* ⚙️ Runtime configuration of gateways and save strategies (immediate/deferred)

---

## 🏗️ Architecture – Modularity & Patterns

Bitshelf adopts a modular, scalable structure, organized into clear layers:

```bash
lib/
├── main.dart                # Entry point
├── controllers/             # Logic and coordination between UI and services
├── core/                    # App configuration, CRUD strategies, utilities
├── data/                    # Models, gateways, repositories
│   ├── models/              # Data classes (Book, User)
│   ├── gateway/             # Data access (CSV, fake, encrypted)
│   └── repository/          # Abstract storage logic
├── services/                # Business logic and data operations
│   ├── encryption/          # Encryption services
│   └── Filter/              # Filtering and search (Chain of Responsibility)
├── view/                    # UI, widgets, pages, and assets
│   ├── ui/                  # Main widgets and pages
│   └── widgets/             # Reusable components (sidebar, drawer, etc.)
```

- **Patterns used:** Repository, Strategy, Decorator, Chain of Responsibility, Observer
- **Extensibility:** Easily add new gateways, strategies, or filters
- **Security:** Encryption and permission management for sensitive operations
- **Reactivity:** Automatic UI updates via Provider and ChangeNotifier

---

## 🚀 Why Bitshelf?

Bitshelf is designed for anyone who wants to manage their library flexibly, securely, and with a modern touch, with the ability to customize and expand features as needed. Perfect for personal use, book clubs, or educational settings.

---

Designed to be modular, scalable, and easily maintainable — the ideal solution to get your library digital!
