const express = require('express');
const endpoints = require('../../../endpoints');
const PaymentCard = require('../../../model/payment_card');
const arsenal = require('../arsenal/delete_card_arsenal');

const deleteCardRoute = express.Router();

deleteCardRoute.post(endpoints.DELETE_CARD_ENDPOINT, async (req, res) => {
    const { cardId } = req.body;
    try {
        await arsenal.deleteCard(cardId);

        res.status(200).json('Card deleted successfully');

    } catch (e) {
        console.log(e);
        arsenal.reportError(e, res);
    }
});
module.exports = deleteCardRoute;

