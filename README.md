# Flutter E-Commerce Showcase

A **production-ready**, **portfolio-grade** e-commerce application built with **Flutter** and clean architecture principles. This project demonstrates best practices in mobile app development, including feature-based architecture, state management, reusable components, multi-language support, and theme switching.

**Perfect for:** GitHub + LinkedIn portfolio, demonstrating your skills to potential employers and clients.

---

## 🎯 Project Overview

**ShopWave** is a fully-functional e-commerce showcase app with:

- ✅ No backend dependencies (no Firebase, no API calls)
- ✅ Clean, professional UI inspired by Material 3
- ✅ Feature-based architecture ready to scale
- ✅ Dummy data seeded locally for immediate use
- ✅ Multi-language support (English & Spanish)
- ✅ Light & Dark theme switching
- ✅ Professional state management with Provider
- ✅ Reusable, well-documented widget components

This is a **frontend showcase project** designed to impress recruiters and demonstrate architectural mastery.

---

## ✨ Features

### 🏠 Home Screen

- **Product Grid** with category filtering
- **Horizontal Category Carousel** for quick navigation
- **Banner Slider** showcasing promotions
- **Search Bar UI** with dummy search logic
- **Featured Products** section
- Responsive layout for all screen sizes

### 📦 Product Detail Screen

- High-quality product images
- Detailed product information
- Price display with discount badges
- Star rating and review count
- **Quantity Selector** (± controls)
- **Add to Cart** button with confirmations
- Smooth navigation and animations

### 🛒 Cart Screen

- List of added products with images
- Quantity adjustment controls
- Individual item removal
- **Real-time pricing:**
  - Subtotal calculation
  - Tax calculation (8%)
  - Shipping cost (free over $49)
  - Grand total display
- **Checkout button** with order confirmation
- Empty state UI

### 👤 Profile Screen

- User profile information
- **Theme Toggle** (Light/Dark mode)
- **Language Toggle** (English/Spanish)
- Settings and preferences
- Clean, organized layout

---

## 🏗️ Architecture: Feature-Based Clean Architecture

```
lib/
├── core/
│   ├── constants/
│   │   ├── app_colors.dart          # Centralized color palette
│   │   ├── app_strings.dart         # All user-facing strings
│   │   └── dummy_data.dart          # Local product database
│   │
│   ├── theme/
│   │   └── app_theme.dart           # Light & Dark themes (Material 3)
│   │
│   ├── utils/
│   │   └── app_toast.dart           # Global toast notifications
│   │
│   ├── widgets/
│   │   ├── app_text.dart            # Semantic typography
│   │   ├── app_loader.dart          # Loading indicators
│   │   ├── custom_button.dart       # Reusable button component
│   │   ├── custom_text_field.dart   # Reusable text input
│   │   ├── quantity_selector.dart   # ± Quantity control
│   │   └── product_card.dart        # Reusable product display card
│   │
│   └── localization/
│       └── app_localizations.dart   # Multi-language support (EN, ES)
│
├── features/
│   ├── home/
│   │   ├── screens/
│   │   │   └── home_screen.dart
│   │   └── widgets/
│   │       ├── banner_slider.dart
│   │       ├── category_list.dart
│   │       └── search_bar_widget.dart
│   │
│   ├── product/
│   │   ├── models/
│   │   │   └── product_model.dart
│   │   └── screens/
│   │       └── product_detail_screen.dart
│   │
│   ├── cart/
│   │   ├── models/
│   │   │   └── cart_item_model.dart
│   │   ├── providers/
│   │   │   └── cart_provider.dart
│   │   ├── screens/
│   │   │   └── cart_screen.dart
│   │   └── widgets/
│   │       └── cart_item_widget.dart
│   │
│   └── profile/
│       ├── providers/
│       │   ├── theme_provider.dart
│       │   └── locale_provider.dart
│       └── screens/
│           └── profile_screen.dart
│
├── routes/
│   └── app_routes.dart              # Named route definitions
│
├── app.dart                         # App configuration & routing
├── main_scaffold.dart               # Bottom navigation scaffold
└── main.dart                        # Entry point
```

### Why This Architecture?

✅ **Scalability** – Easy to add new features without touching existing code  
✅ **Testability** – Each feature is isolated and independently testable  
✅ **Maintainability** – Clear separation of concerns with minimal coupling  
✅ **Reusability** – Common components live in `core/`, avoiding duplication  
✅ **Professional Grade** – Matches industry standards used by major apps

---

## 🛠️ Tech Stack

| Category             | Technology                   |
| -------------------- | ---------------------------- |
| **Framework**        | Flutter (Dart)               |
| **State Management** | Provider                     |
| **Localization**     | flutter_localizations + intl |
| **Design**           | Material 3 (Material You)    |
| **Notifications**    | fluttertoast                 |
| **Indicators**       | smooth_page_indicator        |
| **Code Quality**     | Dart null safety, linting    |

---

## 📱 Screenshots

### Home Screen

![Home - Light Mode](https://via.placeholder.com/375x812?text=Home+Screen)
![Home - Dark Mode](https://via.placeholder.com/375x812?text=Home+Dark)

### Product Detail

![Product Detail](https://via.placeholder.com/375x812?text=Product+Detail)

### Shopping Cart

![Cart - Empty](https://via.placeholder.com/375x812?text=Cart+Empty)
![Cart - Full](https://via.placeholder.com/375x812?text=Cart+Full)

### Profile & Settings

![Profile Screen](https://via.placeholder.com/375x812?text=Profile)

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (v3.9.2 or higher)
- Dart SDK (comes with Flutter)
- An IDE (VS Code, Android Studio, or Xcode)

### Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/Ali508208/Ecommerce-app.git
   cd Ecommerce-app
   ```

2. **Install dependencies:**

   ```bash
   flutter pub get
   ```

3. **Run the app:**
   ```bash
   flutter run
   ```

### Running on Specific Devices

```bash
# iOS
flutter run -d iphone

# Android
flutter run -d android-device-id

# Web
flutter run -d chrome

# Windows
flutter run -d windows
```

---

## 💡 Code Highlights

### 1. **State Management with Provider**

```dart
// Access the cart anywhere
context.read<CartProvider>().addToCart(product);
context.watch<CartProvider>().grandTotal;
```

### 2. **Reusable Widgets**

```dart
// Consistent button styling across the app
CustomButton(label: 'Add to Cart', onPressed: () {})
CustomButton.outlined(label: 'Save', onPressed: () {})

// Semantic typography
AppText.headlineLarge('Product Title')
AppText.bodyMedium('Description', maxLines: 2)
```

### 3. **Centralized Strings**

```dart
// No hardcoded text in UI; localization-ready
AppStrings.cartCheckout
AppStrings.productAddToCart
```

### 4. **Theme Management**

```dart
// Beautiful Material 3 themes
context.read<ThemeProvider>().toggleTheme()
// Instantly switches entire app to dark mode
```

### 5. **Clean Routing**

```dart
// Type-safe navigation without string literals
AppRoutes.goToProductDetail(context, product);
AppRoutes.goToCart(context);
```

---

## 🎨 Design Principles

- **Material 3 Compliance** – Uses the latest Google design guidelines
- **Consistent Spacing** – 8px grid-based layout system
- **Soft Shadows** – Depth without harshness
- **Rounded Corners** – Modern, friendly aesthetic
- **Professional Color Palette** – Carefully chosen for accessibility
- **Responsive Design** – Works on phones, tablets, and foldables

---

## 📚 Why This Project is Portfolio-Ready

✅ **Shows Architecture Knowledge** – Feature-based clean architecture is industry standard  
✅ **Demonstrates Best Practices** – Provider, null safety, proper error handling  
✅ **Production-Quality Code** – Well-organized, commented, and maintainable  
✅ **Professional UI/UX** – Looks like a real app, not a tutorial project  
✅ **Multi-Language Support** – Shows internationalization skills  
✅ **Theme System** – Advanced state management and UI adaptation  
✅ **Scalable Structure** – Easy to add features in real interviews  
✅ **GitHub-Ready** – Clean git history, proper README, well-documented code

This project demonstrates that you can:

- Design and implement professional applications
- Follow architectural best practices
- Write clean, maintainable code
- Understand state management patterns
- Implement localization and theming
- Build production-level features

---

## 🤝 How to Use This in Interviews

1. **Walk Through the Architecture** – Explain the feature-based structure
2. **Show Reusable Components** – Demonstrate how `ProductCard` is used everywhere
3. **Discuss State Management** – Explain CartProvider and ThemeProvider patterns
4. **Live Code a Feature** – Add a new feature (e.g., filters) to show your skills
5. **Mention Trade-offs** – Discuss why you chose Provider over Riverpod, etc.

---

## 📝 Future Enhancement Ideas

- Add real API integration (Firebase Firestore)
- Implement user authentication & profiles
- Add wishlist functionality
- Product filters & sorting
- Order history & tracking
- Push notifications
- Payment gateway integration
- Offline caching with Hive
- Unit & widget tests

---

## 📄 License

This project is open source and available under the MIT License. Feel free to fork, modify, and use it as a template for your own projects.

---

## 👨‍💻 Author

Built as a portfolio showcase to demonstrate Flutter expertise and clean architecture principles.

**Questions or feedback?** Feel free to open an issue or reach out!

---

**Happy coding! 🚀**
