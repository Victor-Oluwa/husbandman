const express = require('express');
const endpoints = require('../../../endpoints');
const Cart = require('../../../model/cart');
const arsenal = require('../arsenal/delete_cart_item_arsenal');

const deleteCartItemRoute = express.Router();

deleteCartItemRoute.post(endpoints.DELETE_CART_ITEM, async (req, res) => {
    console.log('They tried to delete me!');
    try {
        const { ownerId, itemId } = req.body;
        let cart = await arsenal.findCart(ownerId);
        let updatedCart = await arsenal.deleteCartItem(cart, itemId);
        await updatedCart.save();
        console.log(updatedCart);

        res.status(200).json(updatedCart);

    } catch (e) {
        console.log(e);
        arsenal.reportError(e, res);
    }


});

module.exports = deleteCartItemRoute;