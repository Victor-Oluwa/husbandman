const express = require('express');
const endpoints = require('../../../../endpoints');
const Flutterwave = require('flutterwave-node-v3');

const flw = new Flutterwave(process.env.FLW_PUBLIC_KEY, process.env.FLW_SECRET_KEY);
const initCardFundingRoute = express.Router();

initCardFundingRoute.post(endpoints.INITIALIZE_CARD_FUNDING, async (req, res) => {
    try {
        const { cardNumber, cvv, expiryYear, expiryMonth, currency, amount, redirect_url, fullname, email, phone, ref, } = req.body;
        const payload = {
            "card_number": cardNumber,
            "cvv": cvv,
            "expiry_month": expiryMonth,
            "expiry_year": expiryYear,
            "currency": currency,
            "amount": amount,
            "redirect_url": redirect_url,
            "fullname": fullname,
            "email": email,
            "phone_number": phone,
            "enckey": process.env.FLW_ENCRYPTION_KEY,
            "tx_ref": ref,
        }

        const response = await flw.Charge.card(payload);

        const mode = response?.meta?.authorization?.mode;

        switch (mode) {
            case 'pin':
                return res.status(200).json({
                    message: "pinRequired",
                    payload: payload,
                });

            case 'redirect':
                var url = response.meta.authorization.redirect;
                return res.status(200).json({
                    message: "redirecting",
                    url: url,
                    transactionId: response.data.id,
                });

            case 'avs_noauth':
                return res.status(200).json({
                    message: "addressRequired",
                    payload: payload,
                });

            default:
                if (response.status == 'success') {
                    return res.status(200).json({
                        message: "verify",
                        transactionId: response.data.id,
                    });
                } else {
                    return res.status(500).json(`Initialization failed: ${response.status}`);

                }

        }
    } catch (e) {
        console.log(e.message);
        res.status(500).json(e.message);
    }
});

module.exports = initCardFundingRoute;
