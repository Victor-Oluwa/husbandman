const mongoose = require('mongoose');

const farmerSchema = mongoose.Schema({
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
        default: ''
    },
    type: {
        type: String,
        default: 'Farmer'
    },
    phone: {
        type: [String],
        default: '',
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
        default: 0,
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