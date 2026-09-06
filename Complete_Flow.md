The API request should looks like:

{
  "productId": "66f...",
  "variantId": "66f...",
  "emiPlanId": "66f..."
}

And backend should returns this:

{
  "success": true,
  "message": "Marketplace plan selected successfully",
  "order": {
    "productId": "...",
    "productName": "Apple iPhone 16",
    "variant": {
      "value": "256 GB",
      "price": 89900
    },
    "emiPlan": {
      "tenureMonths": 12,
      "monthlyAmount": 6658
    }
  }
}
