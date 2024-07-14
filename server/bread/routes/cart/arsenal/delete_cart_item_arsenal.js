const Cart = require('../../../model/cart');
const error = require('../../../error');
const status = require('../../../status');

async function findCart(ownerId) {
    let cart = await Cart.findOne({ ownerId: ownerId });

    if (!cart) {
        throw new Error(error.USER_CART_NOT_FOUND);
    }

    return cart;
}

async function deleteCartItem(cart, itemId) {
    // Find the index of the item with the given id
    const index = cart.items.findIndex(item => item._id.toString() === itemId);

    // Check if the item was found
    if (index === -1) {
        throw new Error(error.FAILED_TO_FIND_CART_ITEM);
    }

    // Remove the item from the items array
    cart.items.splice(index, 1);

    // Return the updated cart
    return cart;
}

function reportError(e, res) {
    if (e.message == error.FAILED_TO_FIND_CART_ITEM) {
        res.status(status.FAILED_TO_FIND_CART_ITEM).json(e.message);
        return;
    }

    if (e.message == error.USER_CART_NOT_FOUND) {
        res.status(status.USER_CART_NOT_FOUND).json(e.message);
        return;
    }

    console.log(e);
    res.status(500).json(e);
}


module.exports = { findCart, deleteCartItem, reportError };