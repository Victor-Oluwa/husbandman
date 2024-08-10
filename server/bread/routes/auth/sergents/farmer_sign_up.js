const express = require('express');
const authMW = require('../../../middlewere/auth_middlewere');
const endpoints = require('../../../endpoints');
const arsenal = require('../arsenal/sign_up_arsenal');
const farmerArsenal = require('../arsenal/farmer_sign_up_arsenal');
const InvitationKey = require('../../../model/invitation_key');
const Seller = require('../../../model/seller');

const router = express.Router();

router.post(endpoints.FARMER_SIGNUP, async (req, res) => {

    try {
        const { name, email, password, type, invitationKey, } = req.body;

        console.log('Passed Key: ' + invitationKey);
        await arsenal.checkIfUserAlreadyExist(email, type);

        let hashedPassword = await arsenal.hashPassword(password);

        const key = await farmerArsenal.findKey(invitationKey);
        let assignedKey = await farmerArsenal.assignKey(key, email, name);

        assignedKey = await assignedKey.save();
        let newSeller = new Seller({
            name: name,
            email: email,
            password: hashedPassword,
        });


        newSeller = await newSeller.save();
        let token = await arsenal.createJWT(newSeller);
        res.status(200).json({ token, ...newSeller._doc });

    } catch (error) {
        arsenal.reportError(error, res);
        console.log(error);
    }


});

module.exports = router;
