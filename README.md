# QuickShop - E-Commerce Product Catalog

## Overview

Store App is a Flutter-based mobile application that provides a comprehensive e-commerce product browsing experience. The app features a clean, intuitive interface with four main sections: Products, Categories, Favorites, and User Profile. It integrates with the dummyjson API to deliver real product data in a responsive layout.

## Key Features

- **Product Catalog**: Browse an extensive collection of products with detailed information
- **Category Navigation**: Explore products organized by categories
- **Favorites Management**: Bookmark and manage favorite products
- **Search Functionality**: Quickly find products across all sections
- **Responsive Design**: Optimized for various screen sizes
- **State Management**: Efficient handling of application state and data

## Technical Specifications

### Architecture
- Clean Architecture principles
- BLoC pattern for state management
- Repository pattern for data layer

### API Integration
- Products: `https://dummyjson.com/products?limit=100`
- Single Product: `https://dummyjson.com/products/{productId}`
- Categories: `https://dummyjson.com/products/categories`

### Dependencies

| Category          | Packages                          |
|-------------------|-----------------------------------|
| State Management  | provider, flutter_bloc, equatable |
| Networking        |  dio                        |
| UI Components     | cached_network_image, flutter_screenutil |
| Utilities         | intl, path_provider              |
| Development       | freezed, json_serializable, build_runner |

## Installation

### Setup Instructions

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/store_app.git
   ```

2. Navigate to project directory:
   ```bash
   cd store_app
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Generate necessary files:
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

5. Run the application:
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── blocs/
├── configs/
├── models/
├── providers/
├── router/
├── static/
├── ui/
│   ├── screens/
│   ├── widgets/
└── main.dart
```

## Screens

1. **Splash Screen**: Branding and initial loading
2. **Products Screen**: Grid/list view of all products
3. **Categories Screen**: List of product categories
4. **Category Products Screen**: Filtered products by category
5. **Product Details Screen**: Comprehensive product information
6. **Favorites Screen**: User's saved products
7. **Profile Screen**: User information display
