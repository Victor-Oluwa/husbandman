const express = require('express');
const CardFundingHistory = require('../../../../model/card_funding_history');
const endpoints = require('../../../../endpoints');

const addNewCardFundingHistoryRoute = express.Router();

addNewCardFundingHistoryRoute.post(endpoints.ADD_NEW_CARD_FUNDING_HISTORY, async (req, res) => {
    try {
        const {
            fundingStatus, cardNumber, userEmail, cardHolderName,
            userId, transactionId, date, failureMessage,
            failureStage, time, userLocation
        } = req.body;


        if (!fundingStatus || !cardNumber || !userEmail || !cardHolderName ||
            !userId || !transactionId || !date) {
            console.log(fundingStatus + cardNumber + userEmail + cardHolderName + userId + transactionId, date);
            return res.status(400).json({ message: 'Missing required fields' });
        }

        const newHistory = new CardFundingHistory({
            fundingStatus,
            cardNumber,
            userEmail,
            cardHolderName,
            userId,
            transactionId,
            date,
            failureMessage,
            failureStage,
            time,
            userLocation,
        });

        const savedHistory = await newHistory.save();
        res.status(201).json(savedHistory._id);

    } catch (e) {
        console.log(e);
        res.status(500).json(e.message);
    }
});

module.exports = addNewCardFundingHistoryRoute;
