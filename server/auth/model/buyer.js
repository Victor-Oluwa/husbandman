const mongoose = require('mongoose');

const buyerSchema = mongoose.Schema({
    name: {
        type: String,
        required: true,
        trim: true,
    },
    email: {
        type: String,
        required: true,
        trim: true,
    },
    password: {
        type: String,
        required: true
    },
    address: {
        type: String,
        required: true,
    },
    balance: {
        type: Number,
        default: 0.0
    },
    dealingsId: {
        type: [String],
        default: [''],
    },
    lastSeen: {
        type: String,
        default: '',
    },
    type: {
        type: String,
        required: true
    },
    phone: {
        type: [String],
        default: '',
    },
    notifications: {
        type: [String],
        default: '',
    },
    cartIds: {
        type: [String],
        default: ['']
    },
    customers: {
        type: [String],
        default: [''],
    },
    profilePic: {
        type: String,
        default: '',
    },
});

const Buyer = mongoose.model('Buyer', buyerSchema);
module.exports = Buyer;