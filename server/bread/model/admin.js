const mongoose = require('mongoose');
// const validating = require('validatorjs');

const adminSchema = mongoose.Schema({
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
        default: '',
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
        default: [''],
    },
    notifications: {
        type: [String],
        default: [''],
    },
});

const Admin = mongoose.model('Admin', adminSchema);
module.exports = Admin;