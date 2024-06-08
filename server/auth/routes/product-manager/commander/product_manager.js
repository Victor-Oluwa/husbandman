
const express = require('express');
const uploadProduct = require('../sergent/upload_product');
const fetchAllProducts = require('../sergent/fetch_all_product');
const fetchProductByCategory = require('../sergent/fetch_product_by_category');

const productManagerRouter = express.Router();

//Sergents
productManagerRouter.use(uploadProduct);
productManagerRouter.use(fetchAllProducts);
productManagerRouter.use(fetchProductByCategory);

// Export File
module.exports = productManagerRouter;