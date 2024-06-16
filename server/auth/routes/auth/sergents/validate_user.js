const express = require('express');
const endpoints = require('../../../endpoints');
const authMW = require('../../../middlewere/auth_middlewere');
const arsenal = require('../arsenal/validate_user_arsenal');
const router = express.Router();


router.post(endpoints.VALIDATE_USER, authMW, async (req, res) => {
    console.log('1');


    try {
        const token = await arsenal.getToken(req);
        const user = await arsenal.verifyToken(token);
        await user.save();

        res.status(200).json({ token: req.token, ...user._doc });

    } catch (e) {
        arsenal.reportError(e, res);
    }
});

module.exports = router;