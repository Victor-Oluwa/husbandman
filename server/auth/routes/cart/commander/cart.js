const express = require('express');
const fetchCartRouter = require('../sargents/fetch_cart');
const deleteCartItemRoute = require('../sargents/delete_cart_item');
const updateItemRouter = require('../sargents/update_item_quantity');

const cartRoute = express.Router();

cartRoute.use(fetchCartRouter);
cartRoute.use(deleteCartItemRoute);
cartRoute.use(updateItemRouter);


module.exports = cartRoute;