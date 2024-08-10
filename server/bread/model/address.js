const mongoose = require('mongoose');

const addressSchema = new mongoose.Schema({
    fullAddress: { type: String, required: true },
    city: { type: String, required: true },
    state: { type: String, required: true },
    country: { type: String, required: true },
    zipCode: { type: String, required: true },
})


module.exports = addressSchema;