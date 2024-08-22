const mongoose = require('mongoose');
const { Schema } = mongoose;

const productSchema = new Schema({
    name: { type: String, required: true },
    sellerName: { type: String, required: true },
    sellerEmail: { type: String, required: true },
    sellerId: { type: String, required: true },
    video: { type: String, default: '' },
    images: { type: Array, required: true },
    isLive: { type: Boolean, default: true },
    numberSold: { type: Number, default: 0 },
    quantityAvailable: { type: Number, required: true },
    price: { type: Number, required: true },
    deliveryDate: { type: String, required: true },
    description: { type: String, required: true },
    measurement: { type: String, required: true },
    isAlwaysAvailable: { type: Boolean, default: false },
    deliveryLocations: { type: Array, required: true },
    rating: { type: Array, default: [] },
    likes: { type: Number, default: 0 },
    category: { type: String, required: true }
});

const Product = mongoose.model('Product', productSchema);

module.exports = Product;
