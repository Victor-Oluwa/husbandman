const mongoose = require('mongoose');

const cartItemSchema = new mongoose.Schema({
    productId: { type: String, required: true },
    productName: { type: String, required: true },
    productImage: { type: String, required: true },
    quantity: { type: Number, required: true },
    sellerName: { type: String, required: true },
    sellerEmail: { type: String, required: true },
    price: { type: Number, required: true },
    deliveryDate: { type: String, default: '' },
    percentage: { type: Number, default: 0.0 },
});

const cartSchema = new mongoose.Schema({
    ownerId: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
    items: [cartItemSchema],
});

const Cart = mongoose.model('Cart', cartSchema);

module.exports = Cart;