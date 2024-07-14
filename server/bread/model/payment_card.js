const mongoose = require('mongoose');

const paymentCardSchema = new mongoose.Schema({
    type: { type: String, required: true },
    ccv: { type: String, required: true },
    expiryDate: { type: String, required: true },
    holderName: { type: String, required: true },
    number: { type: String, required: true },
    ownerId: { type: String, required: true },
    label: { type: String, required: true },

});


const PaymentCard = mongoose.model('PaymentCard', paymentCardSchema);

module.exports = PaymentCard;