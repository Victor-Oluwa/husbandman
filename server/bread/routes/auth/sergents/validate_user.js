const express = require('express');
const endpoints = require('../../../endpoints');
const authMW = require('../../../middlewere/auth_middlewere');
const arsenal = require('../arsenal/validate_user_arsenal');
const router = express.Router();


router.post(endpoints.VALIDATE_USER, authMW, async (req, res) => {

    try {
        const token = await arsenal.getToken(req);
        const user = await arsenal.verifyToken(token);
        await user.save();

        res.status(200).json({ token: req.token, ...user._doc });

    } catch (e) {
        console.log();
        res.status(500).json(e.message);
    }
});

module.exports = router;