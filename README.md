# Store App - E-Commerce Product Catalog

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

| Category         | Packages                                 |
| ---------------- | ---------------------------------------- |
| State Management | provider, flutter_bloc, equatable        |
| Networking       | http, dio                                |
| UI Components    | cached_network_image, flutter_screenutil |
| Utilities        | intl, path_provider                      |
| Development      | freezed, json_serializable, build_runner |

## Installation

### Prerequisites

- Flutter SDK (version 3.7.2 or higher)
- Dart SDK (version 3.0.0 or higher)
- Android Studio/Xcode (for emulator/simulator)

### Setup Instructions

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/store_app.git
   ```
