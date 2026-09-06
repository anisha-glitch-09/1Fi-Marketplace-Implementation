# 1Fi-Marketplace-Implementation
Assignment Provided by 1Fi for Implementation Of Marketplace

# 1Fi Marketplace

A Flutter-based implementation of the 1Fi Marketplace feature.

## Objective

The project extends the existing Shop experience with a new:

> 1Fi Marketplace

The Marketplace allows users to:

- Browse products
- Search products
- Filter products by category
- View product details
- Select product variants
- View EMI plans
- Select an EMI plan
- Proceed with the selected EMI plan

## Tech Stack

### Frontend

- Flutter
- Dart
- Provider
- Material 3

### Backend

- Node.js
- Express.js
- MongoDB
- Mongoose

## Architecture

Flutter UI -> Provider -> API Service -> Express API -> MongoDB

## API Endpoints

GET /api/products

GET /api/products/:id

POST /api/orders

GET /api/health

## Run Backend

cd backend

npm install

npm run seed

npm run dev

## Run Flutter

cd flutter_app

flutter pub get

flutter run

## Features

### Shop

- Top Brands placeholder
- Nearby Stores placeholder
- 1Fi Marketplace

### Marketplace

- Product listing
- Search
- Category filtering
- Product cards
- Product details
- Product variants
- EMI plans
- EMI selection
- Proceed CTA
- Loading state
- Error state
- Empty state
- Pull to refresh

## Engineering Decisions

Product and EMI data are not hardcoded inside UI components.

The Flutter application retrieves product data from the backend API.

Marketplace state is managed using Provider.

The backend uses MongoDB for product and EMI data.

## Future Improvements

- Authentication
- User portfolio integration
- Real payment gateway
- Real EMI eligibility API
- Order history
- Wishlist
- Product reviews
- Pagination
- Analytics
