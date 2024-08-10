const express = require('express');
const createOrderRoute = require('../sergent/create_order');

const orderRoute = express.Router();

orderRoute.use(createOrderRoute);

module.exports = orderRoute;