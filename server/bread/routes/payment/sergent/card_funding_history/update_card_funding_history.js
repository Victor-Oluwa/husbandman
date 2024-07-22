const express = require('express');
const endpoints = require('../../../../endpoints');
const CardFundingHistory = require('../../../../model/card_funding_history');
const error = require('../../../../error');
const status = require('../../../../status');

const updateCardFundingHistoryRoute = express.Router();

const validFields = [
    'transactionId', 'userEmail', 'fundingStatus',
    'failureStage', 'failureMessage', 'time', 'userLocation', 'date', 'isBrowserAuth',
];

updateCardFundingHistoryRoute.post(endpoints.UPDATE_CARD_FUNDING_HISTORY, async (req, res) => {
    try {
        const { historyId, value, culprit } = req.body;

        if (!historyId || !Array.isArray(value) || !Array.isArray(culprit) || value.length === 0 || culprit.length === 0 || value.length !== culprit.length) {
            return res.status(400).json({ message: 'Invalid request data' });
        }

        const invalidFields = culprit.filter(field => !validFields.includes(field));
        if (invalidFields.length > 0) {
            return res.status(400).json({ message: 'Invalid fields to update', invalidFields });
        }

        const update = {};
        for (let i = 0; i < culprit.length; i++) {
            update[culprit[i]] = value[i];
        }

        const history = await CardFundingHistory.findByIdAndUpdate(historyId, update, { new: true });

        if (!history) {
            return res.status(status.HISTORY_NOT_FOUND).json({ message: error.HISTORY_NOT_FOUND });
        }

        res.status(200).json(history._id);

    } catch (e) {
        console.log(e);
        res.status(500).json(e.message);
    }
});



module.exports = updateCardFundingHistoryRoute;
