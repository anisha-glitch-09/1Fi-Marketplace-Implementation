Test the API first Before debugging Flutter, test:

GET http://localhost:5000/api/health

Expected output is:

{
  "success": true,
  "message": "Server healthy"
}

Then you should:

GET http://localhost:5000/api/products

Expected output is:

{
  "success": true,
  "count": 6,
  "data": [...]
}

This is important
