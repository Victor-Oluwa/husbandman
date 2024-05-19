
const express = require('express');
const uploadProduct = require('../sergent/upload_product');
const fetchAllProducts = require('../sergent/fetch_all_product');

const productManagerRouter = express.Router();

//Sergents
productManagerRouter.use(uploadProduct);
productManagerRouter.use(fetchAllProducts);

// Export File
module.exports = productManagerRouter;