const mongoose = require('mongoose');
const { Schema } = mongoose;

const productSchema = new Schema({
    name: {
        type: String,
        required: true
    },
    video: {
        type: String,
        default: ''
    },
    images: {
        type: [String],
        required: true
    },
    sellerName: {
        type: String,
        required: true
    },
    sellerEmail: {
        type: String,
        required: true
    },
    available: {
        type: Boolean,
        default: true
    },
    sold: {
        type: Number,
        default: 0
    },
    quantity: {
        type: Number,
        required: true
    },
    price: {
        type: Number,
        required: true
    },
    deliveryTime: {
        type: String,
        default: ''
    },
    description: {
        type: String,
        required: true
    },
    measurement: {
        type: String,
        default: ''
    },
    alwaysAvailable: {
        type: Boolean,
        default: false
    },
    deliveryLocations: {
        type: [String],
        required: true
    },
    rating: {
        type: [Number],
        default: []
    },
    likes: {
        type: Number,
        default: 0
    },
    type: {
        type: String,
        default: 'Grain'
    }
});

const Product = mongoose.model('Product', productSchema);

module.exports = Product;
