const express = require("express");
const Product = require("../models/Product");

const router = express.Router();
// This part is API part
/**
 * GET /api/products
 *
 * Optional: Only for testing; optional part is ADDED
 * category=Electronics
 * search=iPhone
 */
// I am a backend engineer, and I created this by myself, not AI-generated, but yes, I have taken only 10% help from AI.
router.get("/", async (req, res) => {
  try {
    const { category, search } = req.query;

    const filter = {
      available: true
    };

    if (category && category !== "All") {
      filter.category = category;
    }

    if (search) {
      filter.$or = [
        {
          name: {
            $regex: search,
            $options: "i"
          }
        },
        {
          brand: {
            $regex: search,
            $options: "i"
          }
        }
      ];
    }

    const products = await Product.find(filter).sort({
      createdAt: -1
    });

    res.json({
      success: true,
      count: products.length,
      data: products
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: "Failed to fetch products",
      error: error.message
    });
  }
});
// Taking API From APP then we will implement this
/**
 * GET /api/products/:id
 */
router.get("/:id", async (req, res) => {
  try {
    const product = await Product.findById(req.params.id);

    if (!product) {
      return res.status(404).json({
        success: false,
        message: "Product not found"
      });
    }

    res.json({
      success: true,
      data: product
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: "Failed to fetch product",
      error: error.message
    });
  }
});

module.exports = router;
