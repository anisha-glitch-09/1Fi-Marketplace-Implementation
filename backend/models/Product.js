const mongoose = require("mongoose");

const variantSchema = new mongoose.Schema(
  {
    name: {
      type: String,
      required: true
    },
    value: {
      type: String,
      required: true
    },
    price: {
      type: Number,
      required: true
    }
  },
  { _id: true }
);

const emiPlanSchema = new mongoose.Schema(
  {
    tenureMonths: {
      type: Number,
      required: true
    },
    monthlyAmount: {
      type: Number,
      required: true
    },
    totalAmount: {
      type: Number,
      required: true
    },
    interest: {
      type: Number,
      default: 0
    },
    isNoCost: {
      type: Boolean,
      default: true
    }
  },
  { _id: true }
);

const productSchema = new mongoose.Schema(
  {
    name: {
      type: String,
      required: true
    },

    brand: {
      type: String,
      required: true
    },

    category: {
      type: String,
      required: true
    },

    description: {
      type: String,
      required: true
    },

    imageUrl: {
      type: String,
      required: true
    },

    price: {
      type: Number,
      required: true
    },

    originalPrice: {
      type: Number
    },

    rating: {
      type: Number,
      default: 4.5
    },

    variants: [variantSchema],

    emiPlans: [emiPlanSchema],

    available: {
      type: Boolean,
      default: true
    }
  },
  {
    timestamps: true
  }
);

module.exports = mongoose.model("Product", productSchema);
