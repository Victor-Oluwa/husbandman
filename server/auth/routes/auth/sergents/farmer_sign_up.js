const express = require('express');
const authMW = require('../../../middlewere/auth_middlewere');
const endpoints = require('../../../endpoints');
const arsenal = require('../arsenal/buyer_sign_up_arsenal');
const Farmer = require('../../../model/farmer');
const farmerArsenal = require('../arsenal/farmer_sign_up_arsenal');
const InvitationKey = require('../../../model/invitation_key');

const router = express.Router();

router.post(endpoints.FARMER_SIGNUP, async (req, res) => {

    try {
        const { name, email, password, address, invitationKey } = req.body;

        console.log('Passed Key: ' + invitationKey);
        await arsenal.checkIfUserAlreadyExist(email);

        let hashedPassword = await arsenal.hashPassword(password);

        const key = await farmerArsenal.findKey(invitationKey);
        await farmerArsenal.assignKey(key, email);

        let newKey = new InvitationKey({
            ownerEmail: email,
            assigned: true,
            value: key
        });

        newKey = await newKey.save();

        let newFarmer = new Farmer({
            name: name,
            email: email,
            password: hashedPassword,
            address: address,

        });


        newFarmer = await newFarmer.save();
        let token = await arsenal.createJWT(newFarmer);

        res.status(200).json({ token, ...newFarmer._doc });

    } catch (error) {
        arsenal.reportError(error, res);
        console.log(error);
    }


});

module.exports = router;
