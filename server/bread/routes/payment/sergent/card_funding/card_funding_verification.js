const express = require('express');
const endpoints = require('../../../../endpoints');
const Flutterwave = require('flutterwave-node-v3');

const flw = new Flutterwave(process.env.FLW_PUBLIC_KEY, process.env.FLW_SECRET_KEY);

const cardFundingVerificationRoute = express.Router();

cardFundingVerificationRoute.post(endpoints.CARD_FUNDING_VERIFICATION, async (req, res) => {
    try {
        const { transactionId } = req.body;

        const transaction = await flw.Transaction.verify({
            id: transactionId
        });

        if (!transaction || !transaction.data || !transaction.data.status) {
            return res.status(500).json('Transaction verification returned null');
        }

        if (transaction.data.status == "successful") {
            return res.status(200).json('successful');
        } else if (transaction.data.status == "pending") {
            return res.status(200).json('pending');
        } else {
            return res.status(200).json('failed');
        }



    } catch (e) {
        console.log(e);
        res.status(500).json(e);
    }
},);



module.exports = cardFundingVerificationRoute;