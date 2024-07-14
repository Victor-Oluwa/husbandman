const express = require('express');
const router = express.Router();
const authMW = require('../../../middlewere/auth_middlewere');
const endpoints = require('../../../endpoints');
const Buyer = require('../../../model/buyer');
const arsenal = require('../arsenal/buyer_sign_up_arsenal');


router.post(endpoints.BUYER_SIGNUP, async (req, res) => {
    try {
        console.log('Got here');

        const { name, email, password, type, address } = req.body;
        await arsenal.checkIfUserAlreadyExist(email);
        let hashedPassword = await arsenal.hashPassword(password);


        let newBuyer = new Buyer({
            name: name,
            email: email,
            password: hashedPassword,
            address: address,
            type: type,
            balance: 0.0,

        });

        newBuyer = await newBuyer.save();

        let token = await arsenal.createJWT(newBuyer);
        console.log(token);
        res.status(200).json({ token, ...newBuyer._doc });

    } catch (error) {
        arsenal.reportError(error, res);

    }


});

module.exports = router;
