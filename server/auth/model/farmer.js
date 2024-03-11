const mongoose = require('mongoose');
const validating = require('validator');

const farmerSchema = mongoose.Schema({
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
    about: {
        type: String,
        default: '',
    },
    badge: {
        type: Number,
        required: true,
    },
    bannerImage: {
        type: String,
        default: ''
    },
    customers: {
        type: [String],
        default: [''],
    },
    products: {
        type: [String],
        default: ['']
    },
    profilePic: {
        type: String,
        default: '',
    },
});

const Farmer = mongoose.model('Farmer', farmerSchema);
module.exports = Farmer;