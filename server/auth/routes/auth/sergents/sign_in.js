const express = require('express');
const authMW = require('../../../middlewere/auth_middlewere');
const endpoints = require('../../../endpoints');
const arsenal = require('../arsenal/sign_in_arsenal');

const router = express.Router();


router.post(endpoints.SIGN_IN, authMW, async (req, res) => {

    try {
        const { email, password } = req.body;

        let user = await arsenal.checkIfUserIsRegistered(email);
        await arsenal.verifyPassword(password, user);

        res.status(200).json(user);

    } catch (e) {
        arsenal.reportError(e, res);
    }


});

module.exports = router;