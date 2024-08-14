const mongoose = require('mongoose');
const addressSchema = require('./address');
const notificationSchema = require('./notification');
const customerSchema = require('./customer');

const paymentSchema = new mongoose.Schema({
    sellerId: { type: String, required: true },
    orderId: { type: String, required: true },
    productId: { type: String, required: true },
    sellerName: { type: String, required: true },
    timeStamp: { type: String, required: true },
    productName: { type: String, required: true },
    productPrice: { type: Number, required: true },
})

const pendingPaymentSchema = new mongoose.Schema({
    payments: [paymentSchema]
})

const fundSchema = new mongoose.Schema({
    buyerId: { type: String, required: true },
    productId: { type: String, required: true },
    productName: { type: String, required: true },
    amountPending: { type: Number, required: true },
})

const pendingOrderFundsSchema = new mongoose.Schema({
    funds: [fundSchema]
});

const orderedItemsSchema = new mongoose.Schema({
    buyerId: { type: String, required: true },
    buyerName: { type: String, required: true },
    buyerImage: { type: String, required: true },
    buyerEmail: { type: String, required: true },
    buyerAddress: { type: addressSchema, required: true },
    productName: { type: String, required: true },
    productImage: { type: String, required: true },
    productPrice: { type: String, required: true },
    deductable: { type: String, required: true },
    productQuantity: { type: String, required: true },
    productDeliveryDate: { type: String, required: true },
    isItemDelivered: { type: Boolean, required: true }
});

const orderedSchema = new mongoose.Schema({
    totalEarning: { type: Number, default: 0.0 },
    totalDeductible: { type: Number, default: 0.0 },
    orderedItems: [orderedItemsSchema]
})

const sellerSchema = mongoose.Schema({
    name: { type: String, required: true },
    userType: { type: String, default: 'Seller' },
    email: { type: String, required: true },
    password: { type: String, required: true },
    phone: [],
    address: { type: addressSchema },
    dataJoined: { type: Date },
    balance: { type: Number, default: 0 },
    pendingFunds: { type: Number, default: 0 },
    totalWithdrawal: { type: Number, default: 0 },
    orderHistoryId: { type: String, default: '' },
    withdrawHistoryId: { type: String, default: '' },
    fundingHistoryId: { type: String, default: '' },
    about: { type: String, default: '' },
    profilePicture: { type: String, default: '' },
    notification: { type: notificationSchema },
    customer: { type: customerSchema },
    lastSeen: { type: String, default: '' },
    bannerImage: { type: String, default: '' },
    cartId: { type: String, default: '' },
    orderId: { type: String, default: '' },
    ordered: { type: orderedSchema, required: true },
    pendingOrderFunds: { type: pendingOrderFundsSchema, required: true },
    pendingPayment: { type: pendingPaymentSchema, required: true },
})

const Seller = mongoose.model('Seller', sellerSchema);
module.exports = Seller;