const express = require('express');
const endpoints = require('../../../../endpoints');
const CardFundingHistory = require('../../../../model/card_funding_history');
const error = require('../../../../error');

const fetchCardFundingHistory = express.Router();

fetchCardFundingHistory.post(endpoints.FETCH_CARD_FUNDING_HISTORY, async (req, res) => {
    try {
        const allHistory = await CardFundingHistory.find();

        res.status(200).json(allHistory);
    } catch (e) {
        console.error('Error fetching card funding history:', e);
        res.status(500).json('Internal server error');
    }
});

module.exports = fetchCardFundingHistory;
