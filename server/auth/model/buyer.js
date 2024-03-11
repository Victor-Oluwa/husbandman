const mongoose = require('mongoose');
const validating = require('validator');

const buyerSchema = mongoose.Schema({
    name: {
        type: String,
        required: true,
        trim: true,
    },
    email: {
        type: String,
        required: true,
        validate: {
            validator: validating.isEmail
        },
        trim: true,
        unique: true,
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
        required: true
    },
    dealingsId: {
        type: [String],
        default: [''],
    },
    lastSeen: {
        type: String,
    },
    type: {
        type: String,
        required: true
    },
    phone: {
        type: [String],
        required: true,
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