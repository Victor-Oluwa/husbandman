const express = require('express');
const mongoose = require('mongoose');
const Product = require('../../../model/product');
const Cart = require('../../../model/cart');
const error = require('../../../error');
const status = require('../../../status');

async function createCart(newItem, ownerId) {

    const newCart = new Cart({
        ownerId: ownerId,
        items: [newItem],
    });

    console.log('New cart created and item added.');
    return newCart;

}

async function addCart(cart, newItem) {
    cart.items.push(newItem);
    console.log('Item added to existing cart.');

    return cart;

}


// async function updateProductQuantity(product, quantity) {
//     product.quantityAvailable -= quantity;

//     if (product.quantityAvailable < 1) {
//         product.isLive = false;
//     }
//     return product;
// }

async function checkIfProductExistInCart(product, cart) {

    const productExist = cart.items.find(item => item.productId === product._id.toString());
    return productExist;
}

async function checkIfProductIsAvailable(product, quantity) {
    if (!product) {
        throw new Error('Failed to find product by id');
    }

    console.log('Quantity' + quantity);
    console.log('Available' + product.quantityAvailable);

    if (product.quantityAvailable < quantity) {
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
        console.log('PAIC ERROR:' + e.message);
        return res.status(status.PRODUCT_ALREADY_IN_CART).json(e.message);

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
    res.status(500).json(e.message);
}

module.exports = {
    addCart,
    createCart,
    findProductById,
    checkIfProductExistInCart,
    checkIfProductIsAvailable,
    reportError
};