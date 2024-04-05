const express = require('express');
const authMW = require('../../../middlewere/auth_middlewere');
const endpoints = require('../../../endpoints');
const Buyer = require('../../../model/buyer');
const arsenal = require('../arsenal/buyer_sign_up_arsenal');

const router = express.Router();

router.post(endpoints.BUYER_SIGNUP, authMW, async (req, res) => {

    try {
        const { name, email, password, type, address } = req.body;

        await arsenal.checkIfUserAlreadyExist(email);
        let hashedPassword = await arsenal.hashPassword(password);


        let newBuyer = new Buyer({
            name: name,
            email: email,
            password: hashedPassword,
            type: type,
            address: address,

        });

        newBuyer = await newBuyer.save();

        let token = arsenal.createJWT(newBuyer);

        res.status(200).json({ token, ...newBuyer._doc });

    } catch (error) {
        arsenal.reportError(error, res);

    }


});

module.exports = router;
