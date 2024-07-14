const express = require('express');
const endpoints = require('../../../endpoints');
const arsenal = require('../arsenal/update_cart_item_arsenal');

const updateItemRouter = express.Router();

updateItemRouter.post(endpoints.UPDATE_ITEM_QUANTITY, async (req, res) => {
    try {
        const { quantity, itemId, ownerId } = req.body;

        let cart = await arsenal.findCart(ownerId);
        cart = await arsenal.updateCartQuantity(itemId, cart, quantity);

        await cart.save();
        res.status(200).json(cart);

    } catch (e) {
        arsenal.reportError(e, res);
    }

});

module.exports = updateItemRouter;