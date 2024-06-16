
const express = require('express');
const uploadProduct = require('../sergent/upload_product');
const fetchAllProducts = require('../sergent/fetch_all_product');
const fetchProductByCategory = require('../sergent/fetch_product_by_category');
const addProductToCart = require('../sergent/add_product_to_cart');

const productManagerRouter = express.Router();

//Sergents
productManagerRouter.use(uploadProduct);
productManagerRouter.use(fetchAllProducts);
productManagerRouter.use(fetchProductByCategory);
productManagerRouter.use(addProductToCart);

// Export File
module.exports = productManagerRouter;