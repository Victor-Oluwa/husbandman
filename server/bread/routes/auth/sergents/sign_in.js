const express = require('express');
const authMW = require('../../../middlewere/auth_middlewere');
const endpoints = require('../../../endpoints');
const arsenal = require('../arsenal/sign_in_arsenal');
const buyerSignUpArsenal = require('../arsenal/sign_up_arsenal');

const router = express.Router();


router.post(endpoints.SIGN_IN, async (req, res) => {

    try {
        const { email, password } = req.body;

        let user = await arsenal.checkIfUserIsRegistered(email);
        await arsenal.verifyPassword(password, user);
        await arsenal.verifySellerToken(email);

        const token = await buyerSignUpArsenal.createJWT(user);
        console.log('Sign in token: ' + token);
        res.status(200).json({ token: token, ...user._doc });

    } catch (e) {
        console.log(e);
        res.status(500).json(e.message);
    }


});

module.exports = router;