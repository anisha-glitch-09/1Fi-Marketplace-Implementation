const express = require("express");
const mongoose = require("mongoose");
const Product = require("../models/Product");

const router = express.Router();

router.post("/", async (req, res) => {
  try {
    const {
      productId,
      variantId,
      emiPlanId
    } = req.body;

    if (!productId || !emiPlanId) {
      return res.status(400).json({
        success: false,
        message: "Product and EMI plan are required"
      });
    }

    if (!mongoose.Types.ObjectId.isValid(productId)) {
      return res.status(400).json({
        success: false,
        message: "Invalid product ID"
      });
    }

    const product = await Product.findById(productId);

    if (!product) {
      return res.status(404).json({
        success: false,
        message: "Product not found"
      });
    }

    const emiPlan = product.emiPlans.id(emiPlanId);

    if (!emiPlan) {
      return res.status(404).json({
        success: false,
        message: "EMI plan not found"
      });
    }

    let variant = null;

    if (variantId) {
      variant = product.variants.id(variantId);
    }

    res.status(201).json({
      success: true,
      message: "Marketplace plan selected successfully",
      order: {
        productId: product._id,
        productName: product.name,
        variant: variant
          ? {
              id: variant._id,
              name: variant.name,
              value: variant.value,
              price: variant.price
            }
          : null,
        emiPlan: {
          id: emiPlan._id,
          tenureMonths: emiPlan.tenureMonths,
          monthlyAmount: emiPlan.monthlyAmount,
          totalAmount: emiPlan.totalAmount
        }
      }
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: "Failed to proceed",
      error: error.message
    });
  }
});

module.exports = router;
