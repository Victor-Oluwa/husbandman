const mongoose = require('mongoose');
const addressSchema = require('./address');
const notificationSchema = require('./notification');
const customerSchema = require('./customer');


const buyerSchema = mongoose.Schema({
    name: { type: String, required: true },
    userType: { type: String, required: true },
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


})


const Buyer = mongoose.model('Buyer', buyerSchema);

module.exports = Buyer;

