const mongoose = require('mongoose');



const ordersItemsSchema = new mongoose.Schema({
    itemName: { type: String, required: true },
    itemImage: { type: String, required: true },
    itemPrice: { type: Number, required: true },
    isItemDelivered: { type: Boolean, required: true },
    deductible: { type: Number, required: true },
    itemQuantity: { type: Number, required: true }
});

const allOrdersSchema = new mongoose.Schema({
    grossTotal: { type: Number, required: true },
    orderName: { type: String, required: true },
    orderItems: [ordersItemsSchema],
});


const orderSchema = new mongoose.Schema({
    ownerId: { type: String, required: true },
    grandTotal: { type: Number, required: true },
    orders: [allOrdersSchema]
});

const Order = mongoose.model('Order', orderSchema);
module.exports = Order;
