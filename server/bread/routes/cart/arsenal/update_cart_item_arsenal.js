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

async function updateCartQuantity(itemId, cart, quantity) {
    if (!itemId || !cart || !quantity) {
        throw new Error('Some passed arguments are undefined (itemId || cart || quantity)');
    }
    if (!cart.items) {
        throw new Error('cart.items is undefined');
    }

    let cartItem = cart.items.find(item => {
        if (!item._id) {
            throw new Error('item._id is undefined');
        }

        return item._id.toString() === itemId;
    });

    if (cartItem === -1) {
        throw new Error(error.FAILED_TO_FIND_CART_ITEM);
    }
    if (!cartItem.productQuantity) {
        throw new Error('cartItem.quantity is undefined');
    }
    cartItem.productQuantity = quantity;

    console.log('CartItem: ' + cartItem)


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