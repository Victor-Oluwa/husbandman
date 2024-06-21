const express = require('express');
const mongoose = require('mongoose');
const Product = require('../../../model/product');
const Cart = require('../../../model/cart');
const error = require('../../../error');
const status = require('../../../status');

async function addToCart(cart, newItem) {
    const existingItem = cart.items.find(item => item.productId === newItem.productId);

    if (existingItem) {
        existingItem.quantity += newItem.quantity;
    } else {
        cart.items.push(newItem);
    }

    await cart.save();
    console.log('Item added to existing cart.');
    return cart;
}

async function createCart(ownerId, newItem) {
    const newCart = new Cart({
        ownerId: ownerId,
        items: [newItem],
    });

    await newCart.save();
    console.log('New cart created and item added.');
    return newCart;
}

async function updateProductQuantity(product, quantity) {
    product.quantity -= quantity;

    if (product.quantity < 1) {
        product.available = false;
    }
    await product.save();
}

async function checkIfProductExistInCart(product, cartOwnerId) {
    const cart = await Cart.findOne({ ownerId: cartOwnerId });
    const productExist = cart.items.find(item => item.productId === product._id.toString());

    if (productExist) {
        throw new Error(error.PRODUCT_ALREADY_IN_CART);
    }
    return cart;
}

async function checkIfProductIsAvailable(product, quantity) {
    if (!product.available) {
        throw new Error(error.PRODUCT_NOT_AVAILABLE);
    }

    if (product.quantity < quantity) {
        throw new Error(error.PRODUCT_OUT_OF_STOCK);
    }
}

async function findProductById(id) {
    const product = await Product.findById(id);

    if (!product) {
        throw new Error(error.PRODUCT_DOES_NOT_EXIST);
    }

    return product;
}

function reportError(e, res) {
    if (e.message == error.PRODUCT_ALREADY_IN_CART) {
        console.log(e.message);
        res.status(status.PRODUCT_ALREADY_IN_CART).json(e.message);
        return;
    }

    if (e.message == error.PRODUCT_DOES_NOT_EXIST) {
        console.log(e.message);
        res.status(status.PRODUCT_DOES_NOT_EXIST).json(e.message);
        return;
    }

    if (e.message == error.PRODUCT_NOT_AVAILABLE) {
        console.log(e.message);
        res.status(status.PRODUCT_NOT_AVAILABLE).json(e.message);
        return;
    }

    if (e.message == error.PRODUCT_OUT_OF_STOCK) {
        console.log(e.message);
        res.status(status.PRODUCT_OUT_OF_STOCK).json(e.message);
        return;
    }

    console.log(e);
    res.status(500).json(e);
}

module.exports = {
    addToCart,
    createCart,
    findProductById,
    updateProductQuantity,
    checkIfProductExistInCart,
    checkIfProductIsAvailable,
    reportError
};