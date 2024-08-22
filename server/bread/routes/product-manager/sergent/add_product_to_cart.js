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
            buyerId: ownerId,
            sellerId: product.sellerId,
            productName: product.name,
            productImage: product.images[0],
            productQuantity: 1,
            sellerName: product.sellerName,
            sellerEmail: product.sellerEmail,
            productPrice: product.price,
            percentage: product.price * 0.10,
            deliveryDate: product.deliveryDate
        };

        let cart = await Cart.findOne({ ownerId: ownerId });

        if (!cart) {
            cart = await arsenal.createCart(newItem, ownerId);
            // product = await arsenal.updateProductQuantity(product, quantity);

            await cart.save();
        }


        if (cart) {
            let productExist = await arsenal.checkIfProductExistInCart(product, cart);

            if (productExist) {
                console.log('Product already exist in cart');
                return res.status(200).json(cart);

            }

            cart = await arsenal.addCart(cart, newItem);
            // product = await arsenal.updateProductQuantity(product, quantity);

            await cart.save();
        }

        res.status(200).json(cart);

    } catch (e) {

        console.log(e.message);
        res.status(500).json(e.message);
    }
});


module.exports = router;
