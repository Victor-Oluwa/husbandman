const express = require('express');
const Flutterwave = require('flutterwave-node-v3');

const flw = new Flutterwave(process.env.FLW_PUBLIC_KEY, process.env.FLW_SECRET_KEY);
const cardFundingOtpValidationRoute = express.Router();

cardFundingOtpValidationRoute.post('/card/validate-otp', async (req, res) => {
    try {
        const { flw_ref, otp } = req.body;

        const response = await flw.Charge.validate({
            "otp": otp,
            "flw_ref": flw_ref
        });

        if (response.status == 'success') {
            return res.status(200).json(response.data.id);
        }
        res.status(500).json('Validation failed');

    } catch (e) {
        console.log(e);
        res.status(500).json(e.message);
    }
});

module.exports = cardFundingOtpValidationRoute;