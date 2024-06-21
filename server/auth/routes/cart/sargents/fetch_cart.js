const express = require('express');
const Cart = require('../../../model/cart');
const endpoints = require('../../../endpoints');
const arsenal = require('../arsenal/fetch_cart_arsenal');

const fetchCartRouter = express.Router();

fetchCartRouter.post(endpoints.FETCH_CART, async (req, res) => {
    try {
        const { ownerId } = req.body;

        let cart = await arsenal.findCart(ownerId);

        res.status(200).json(cart);

    } catch (e) {
        console.log(e);
        res.status(500).json(e);
    }


});

module.exports = fetchCartRouter;