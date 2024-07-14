const express = require('express');
const endpoints = require('../../../endpoints');
const arsenal = require('../arsenal/add_new_card_arsenal');

const addNewCardRouter = express.Router();

addNewCardRouter.post(endpoints.ADD_NEW_CARD_ENDPOINT, async (req, res) => {

    try {
        const { holderName, cardNumber, expiryDate, ccv, type, ownerId } = req.body;

        await arsenal.checkIfCardExist(cardNumber);
        let newCard = await arsenal.addCard(type, ccv, expiryDate, holderName, cardNumber, ownerId,);

        newCard = await newCard.save();
        res.status(200).json(newCard);


    } catch (e) {
        arsenal.reportError(e, res);
    }

});

module.exports = addNewCardRouter;







