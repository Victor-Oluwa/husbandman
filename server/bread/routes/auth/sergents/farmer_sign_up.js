const express = require('express');
const authMW = require('../../../middlewere/auth_middlewere');
const endpoints = require('../../../endpoints');
const arsenal = require('../arsenal/sign_up_arsenal');
const farmerArsenal = require('../arsenal/farmer_sign_up_arsenal');
// const InvitationKey = require('../../../model/invitation_key');
const Seller = require('../../../model/seller');
const mongoose = require('mongoose');

const router = express.Router();

router.post(endpoints.FARMER_SIGNUP, async (req, res) => {
    const session = await mongoose.startSession();
    session.startTransaction();


    try {
        const { name, email, password, type, invitationKey } = req.body;

        console.log('Passed Key: ' + invitationKey);
        await arsenal.checkIfUserAlreadyExist(email, type, session);

        let hashedPassword = await arsenal.hashPassword(password);

        const key = await farmerArsenal.findKey(invitationKey, session);
        let assignedKey = await farmerArsenal.assignKey(key, email, name, session);

        let newSeller = new Seller({
            name: name,
            email: email,
            password: hashedPassword,
            dataJoined: new Date(),
            userType: type,
        });

        let token = await arsenal.createJWT(newSeller);

        await assignedKey.save({ session });
        await newSeller.save({ session });

        await session.commitTransaction();
        await session.endSession()

        res.status(200).json({ token, ...newSeller._doc });

    } catch (error) {
        await session.abortTransaction();
        await session.endSession();

        console.log(error);
        return res.status(500).json(error.message);
    }


});

module.exports = router;
