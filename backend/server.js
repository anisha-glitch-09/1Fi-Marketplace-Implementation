const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");
require("dotenv").config();

const productRoutes = require("./routes/productRoutes");
const orderRoutes = require("./routes/orderRoutes");

const app = express();

app.use(
  cors({
    origin: "*"
  })
);

app.use(express.json());

app.get("/", (req, res) => {
  res.json({
    message: "1Fi Marketplace API is running"
  });
});

app.get("/api/health", (req, res) => {
  res.json({
    success: true,
    message: "Server healthy"
  });
});

app.use("/api/products", productRoutes);
app.use("/api/orders", orderRoutes);

const PORT = process.env.PORT || 5000;

mongoose
  .connect(process.env.MONGO_URI)
  .then(() => {
    console.log("MongoDB connected");

    app.listen(PORT, () => {
      console.log(
        `Server running on http://localhost:${PORT}`
      );
    });
  })
  .catch((error) => {
    console.error("MongoDB connection failed:", error);
  });
