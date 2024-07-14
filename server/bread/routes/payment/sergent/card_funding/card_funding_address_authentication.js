const express = require('express');
const Flutterwave = require('flutterwave-node-v3');
const endpoints = require('../../../../endpoints');

const flw = new Flutterwave(process.env.FLW_PUBLIC_KEY, process.env.FLW_SECRET_KEY);


const cardFundingAddressAuthRoute = express.Router();

cardFundingAddressAuthRoute.post(endpoints.CARD_FUNDING_ADDRESS_AUTH, async (req, res) => {
    try {
        const { address, city, country, state, zipcode, payload } = req.body;

        let payload2 = payload;
        payload2.authorization = {
            "mode": "avs_noauth",
            "city": city,
            "address": address,
            "state": state,
            "country": country,
            "zipcode": zipcode
        };

        const callCharge = await flw.Charge.card(payload2);
        const mode = callCharge?.meta?.authorization?.mode;

        switch (mode) {
            case 'otp':
                return res.status(200).json({
                    message: mode,
                    transactionId: callCharge.data.id,
                    info: callCharge.data.processor_response,
                    ref: callCharge.data.flw_ref,
                    status: callCharge.data.status,
                });

            case 'redirect':
                return res.status(200).json({
                    message: mode,
                    transactionId: callCharge.data.id,
                    info: callCharge.data.processor_response,
                    url: callCharge.meta.authorization.redirect,
                    status: callCharge.data.status,
                });

            default:
                if (callCharge.status == 'success') {
                    return res.status(200).json({
                        transactionId: callCharge.data.id,
                        info: "verify",
                    });
                } else {
                    res.status(500).json('Authentication with address failed');

                }

        }
    } catch (e) {
        console.log(e)
        res.status(500).json(e.message);
    }
});


module.exports = cardFundingAddressAuthRoute;