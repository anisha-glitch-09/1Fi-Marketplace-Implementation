## Step-1
mkdir 1fi-marketplace
cd 1fi-marketplace

## Step-2
flutter create flutter_app

## Step-3
mkdir backend
cd backend
npm init -y

## Step-4
npm install express mongoose cors dotenv
npm install --save-dev nodemon

## Step-5 After Running seed/products.js run this 4 steps
## 5.1 Run:
cd backend
npm run seed
## 5.2 Then:
npm run dev
## 5.3 You should see:
MongoDB connected
Server running on http://localhost:5000
## 5.4 Test this:
http://localhost:5000/api/products

## Step-6
cd flutter_app

## Step-7 After Updating pubspsc.yaml file
flutter pub get
