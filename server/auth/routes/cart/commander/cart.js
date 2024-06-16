const express = require('express');
const fetchCartRouter = require('../sargents/fetch_cart');

const cartRoute = express.Router();

cartRoute.use(fetchCartRouter);

module.exports = cartRoute;