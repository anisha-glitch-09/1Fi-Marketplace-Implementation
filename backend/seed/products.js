const mongoose = require("mongoose");
require("dotenv").config();

const Product = require("../models/Product");

const products = [
  {
    name: "Apple iPhone 16",
    brand: "Apple",
    category: "Electronics",
    description:
      "iPhone 16 with advanced camera system, powerful performance and all-day battery life.",
    imageUrl:
      "https://images.unsplash.com/photo-1592750475338-74b7b21085ab?w=800",
    price: 79900,
    originalPrice: 84900,
    rating: 4.7,

    variants: [
      {
        name: "Storage",
        value: "128 GB",
        price: 79900
      },
      {
        name: "Storage",
        value: "256 GB",
        price: 89900
      },
      {
        name: "Storage",
        value: "512 GB",
        price: 109900
      }
    ],

    emiPlans: [
      {
        tenureMonths: 3,
        monthlyAmount: 26633,
        totalAmount: 79900,
        interest: 0,
        isNoCost: true
      },
      {
        tenureMonths: 6,
        monthlyAmount: 13317,
        totalAmount: 79900,
        interest: 0,
        isNoCost: true
      },
      {
        tenureMonths: 9,
        monthlyAmount: 8878,
        totalAmount: 79900,
        interest: 0,
        isNoCost: true
      },
      {
        tenureMonths: 12,
        monthlyAmount: 6658,
        totalAmount: 79900,
        interest: 0,
        isNoCost: true
      }
    ]
  },

  {
    name: "Samsung Galaxy S25",
    brand: "Samsung",
    category: "Electronics",
    description:
      "Premium Samsung smartphone with a high-resolution display and powerful processor.",
    imageUrl:
      "https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?w=800",
    price: 74999,
    originalPrice: 79999,
    rating: 4.6,

    variants: [
      {
        name: "Storage",
        value: "128 GB",
        price: 74999
      },
      {
        name: "Storage",
        value: "256 GB",
        price: 79999
      }
    ],

    emiPlans: [
      {
        tenureMonths: 6,
        monthlyAmount: 12500,
        totalAmount: 74999,
        interest: 0,
        isNoCost: true
      },
      {
        tenureMonths: 9,
        monthlyAmount: 8333,
        totalAmount: 74999,
        interest: 0,
        isNoCost: true
      },
      {
        tenureMonths: 12,
        monthlyAmount: 6250,
        totalAmount: 74999,
        interest: 0,
        isNoCost: true
      }
    ]
  },

  {
    name: "Sony WH-1000XM5",
    brand: "Sony",
    category: "Electronics",
    description:
      "Premium wireless noise cancelling headphones with immersive sound.",
    imageUrl:
      "https://images.unsplash.com/photo-1546435770-a3e426bf472b?w=800",
    price: 29990,
    originalPrice: 34990,
    rating: 4.8,

    variants: [
      {
        name: "Color",
        value: "Black",
        price: 29990
      },
      {
        name: "Color",
        value: "Silver",
        price: 29990
      }
    ],

    emiPlans: [
      {
        tenureMonths: 3,
        monthlyAmount: 9997,
        totalAmount: 29990,
        interest: 0,
        isNoCost: true
      },
      {
        tenureMonths: 6,
        monthlyAmount: 4998,
        totalAmount: 29990,
        interest: 0,
        isNoCost: true
      }
    ]
  },

  {
    name: "Nike Air Max",
    brand: "Nike",
    category: "Fashion",
    description:
      "Comfortable everyday sneakers featuring lightweight cushioning.",
    imageUrl:
      "https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=800",
    price: 8995,
    originalPrice: 10995,
    rating: 4.5,

    variants: [
      {
        name: "Size",
        value: "8",
        price: 8995
      },
      {
        name: "Size",
        value: "9",
        price: 8995
      },
      {
        name: "Size",
        value: "10",
        price: 8995
      }
    ],

    emiPlans: [
      {
        tenureMonths: 3,
        monthlyAmount: 2998,
        totalAmount: 8995,
        interest: 0,
        isNoCost: true
      }
    ]
  },

  {
    name: "Dyson Air Purifier",
    brand: "Dyson",
    category: "Home",
    description:
      "Advanced air purification and intelligent monitoring for your home.",
    imageUrl:
      "https://images.unsplash.com/photo-1585771724684-38269d6639fd?w=800",
    price: 42900,
    originalPrice: 45900,
    rating: 4.4,

    variants: [
      {
        name: "Model",
        value: "Pure Cool",
        price: 42900
      },
      {
        name: "Model",
        value: "Pure Hot + Cool",
        price: 52900
      }
    ],

    emiPlans: [
      {
        tenureMonths: 6,
        monthlyAmount: 7150,
        totalAmount: 42900,
        interest: 0,
        isNoCost: true
      },
      {
        tenureMonths: 12,
        monthlyAmount: 3575,
        totalAmount: 42900,
        interest: 0,
        isNoCost: true
      }
    ]
  },

  {
    name: "Apple MacBook Air",
    brand: "Apple",
    category: "Electronics",
    description:
      "Lightweight laptop with excellent performance and battery life.",
    imageUrl:
      "https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=800",
    price: 99900,
    originalPrice: 109900,
    rating: 4.9,

    variants: [
      {
        name: "Memory",
        value: "8 GB",
        price: 99900
      },
      {
        name: "Memory",
        value: "16 GB",
        price: 119900
      }
    ],

    emiPlans: [
      {
        tenureMonths: 6,
        monthlyAmount: 16650,
        totalAmount: 99900,
        interest: 0,
        isNoCost: true
      },
      {
        tenureMonths: 12,
        monthlyAmount: 8325,
        totalAmount: 99900,
        interest: 0,
        isNoCost: true
      }
    ]
  }
];

async function seedDatabase() {
  try {
    await mongoose.connect(process.env.MONGO_URI);

    await Product.deleteMany({});

    await Product.insertMany(products);

    console.log("Products seeded successfully");

    await mongoose.disconnect();
  } catch (error) {
    console.error(error);
    process.exit(1);
  }
}

seedDatabase();
