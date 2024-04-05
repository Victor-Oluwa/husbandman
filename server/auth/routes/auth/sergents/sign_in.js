const express = require('express');
const authMW = require('../../../middlewere/auth_middlewere');
const bcryptjs = require("bcryptjs");
const endpoints = require('../../../endpoints');
const Buyer = require('../../../model/buyer');
const Farmer = require('../../../model/farmer');
const error = require('../../../error');
const status = require('../../../status');
const Admin = require('../../../model/admin');
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