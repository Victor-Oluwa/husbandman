const express = require('express');
const mongoose = require('mongoose');
const endpoints = require('../../../endpoints');
const Cart = require('../../../model/cart');
const arsenal = require('../arsenal/add_product_to_cart_arsenal');

const router = express.Router();

router.post(endpoints.ADD_PRODUCT_TO_CART, async (req, res) => {
    try {
        const { productId, quantity, cartOwnerId } = req.body;

        let product = await arsenal.findProductById(productId);
        await arsenal.checkIfProductIsAvailable(product, quantity);

        const ownerId = cartOwnerId;
        const newItem = {
            productId: product._id,
            productName: product.name,
            productImage: product.images[0],
            productQuantity: quantity,
            sellerName: product.sellerName,
            sellerEmail: product.sellerEmail,
            productPrice: product.price,
            percentage: product.price * 0.10
        };

        let cart = await Cart.findOne({ ownerId: ownerId });

        if (!cart) {
            cart = await arsenal.createCart(ownerId, newItem);
        } else {
            await arsenal.checkIfProductExistInCart(product, cart);
            console.log('Tried adding to crt');
            cart = await arsenal.addToCart(cart, newItem);
        }

        // await arsenal.updateProductQuantity(product, quantity);

        res.status(200).json(cart);

    } catch (e) {
        console.log(e.message);
        res.status(500).json(e.message);
    }
});


module.exports = router;
