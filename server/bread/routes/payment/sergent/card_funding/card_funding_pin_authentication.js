const express = require('express');
const Flutterwave = require('flutterwave-node-v3');
const endpoints = require('../../../../endpoints');

const flw = new Flutterwave(process.env.FLW_PUBLIC_KEY, process.env.FLW_SECRET_KEY);
const cardFundingPinAuthRoute = express.Router();

cardFundingPinAuthRoute.post(endpoints.CARD_FUNDING_PIN_AUTH, async (req, res) => {
    try {
        const { payload, pin } = req.body;
        let payload2 = payload;

        payload2.authorization = {
            "mode": "pin",
            "pin": pin,
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
                        message: "verify",
                        info: "verify",
                    });
                } else {
                    return res.status(500).json('Pin verification failed');
                }

        }
    } catch (e) {
        console.log(e);
        res.status(500).json(e.message);
    }
});

module.exports = cardFundingPinAuthRoute;


// console.log('Authorization flw_ref: ' + callCharge.data.flw_ref);
// console.log('Authorization processor_response: ' + callCharge.data.processor_response);
// console.log('Authorization id: ' + callCharge.data.id);
// console.log('Authorization status: ' + callCharge.data.status);
// console.log('Authorization data: ' + callCharge.data);
