
const Cart = require('../../../model/cart');


async function findCart(ownerId) {
    let cart = await Cart.findOne({ ownerId: ownerId });
    if (!cart) {
        console.log('No cart found for this user');
        return;
    }

    return cart;
}

module.exports = { findCart }