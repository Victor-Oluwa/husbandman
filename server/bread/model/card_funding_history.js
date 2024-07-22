const mongoose = require('mongoose');

const cardFundingHistorySchema = new mongoose.Schema({
    userId: { type: String, required: true },
    cardHolderName: { type: String, required: true },
    userEmail: { type: String, required: true },
    cardNumber: { type: String, required: true },
    fundingStatus: { type: String, required: true },
    transactionId: { type: String, required: true },
    date: { type: Date, required: true },
    time: { type: Date, required: true },
    failureMessage: { type: String, default: '' },
    failureStage: { type: String, default: '' },
    userLocation: { type: String, default: '' },
    isBrowserAuth: { type: Boolean, default: false },
});

const CardFundingHistory = mongoose.model('CardFundingHistory', cardFundingHistorySchema);

module.exports = CardFundingHistory;