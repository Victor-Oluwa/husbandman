const Cart = require('../../../model/cart');
const error = require('../../../error');
const status = require('../../../status');
const Product = require('../../../model/product');


async function findCart(ownerId) {
    let cart = await Cart.findOne({ ownerId: ownerId });

    if (!cart) {
        throw new Error(error.USER_CART_NOT_FOUND);
    }
    return cart;
}

async function updateCartQuantity(itemId, cart, quantity) {

    let cartItem = cart.items.find(item => item._id.toString() === itemId);

    if (cartItem === -1) {
        throw new Error(error.FAILED_TO_FIND_CART_ITEM);
    }


    const product = await Product.findById(cartItem.productId);
    if (!product) {
        throw new Error(`Failed to find product with ID: ${cartItem.productId}`);
    }

    if (product.quantityAvailable > quantity) {
        cartItem.productQuantity = quantity;
    }

    return cart;
}

function reportError(e, res) {
    if (e.message == error.FAILED_TO_FIND_CART_ITEM) {
        console.log(e);
        res.status(status.FAILED_TO_FIND_CART_ITEM).json(e.message);
        return;
    }

    if (e.message == error.USER_CART_NOT_FOUND) {
        console.log(e);
        res.status(status.USER_CART_NOT_FOUND).json(e.message);
        return;
    }

    console.log(e);
    res.status(500).json(e);
}

module.exports = { findCart, updateCartQuantity, reportError }