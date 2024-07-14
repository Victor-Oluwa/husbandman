const express = require('express');
const endpoints = require('../../../endpoints');
const PaymentCard = require('../../../model/payment_card');
const arsenal = require('../arsenal/fetch_all_cards_arsenal');

const fetchAllCardsRoute = express.Router();

fetchAllCardsRoute.post(endpoints.FETCH_ALL_CARDS_ENDPOINT, async (req, res) => {

    try {
        const { ownerId } = req.body;
        const cards = await arsenal.fetchCards(ownerId);
        res.status(200).json(cards);

    } catch (e) {
        console.log(e);
        arsenal.reportError(e, res);
    }

});

module.exports = fetchAllCardsRoute;










