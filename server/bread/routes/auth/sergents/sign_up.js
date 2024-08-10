const express = require('express');
const router = express.Router();
const authMW = require('../../../middlewere/auth_middlewere');
const endpoints = require('../../../endpoints');
const arsenal = require('../arsenal/sign_up_arsenal');
const Buyer = require('../../../model/buyer');
const Seller = require('../../../model/seller');
const Admin = require('../../../model/admin');


router.post(endpoints.SIGNUP, async (req, res) => {
    try {

        const { name, email, password, type } = req.body;

        await arsenal.checkIfUserAlreadyExist(email, type);
        let hashedPassword = await arsenal.hashPassword(password);

        async function saveUser(user) {
            if (!user) {
                console.log(user);
                throw new Error('Invalid user');
            }

            user = await user.save();

            let token = await arsenal.createJWT(user);
            console.log(token);
            res.status(200).json({ token, ...user._doc });
        }

        switch (type) {
            case 'Buyer':
                let newBuyer = new Buyer({
                    name: name,
                    email: email,
                    password: hashedPassword,
                    userType: type,

                });

                return await saveUser(newBuyer);

            case 'Admin':
                let newAdmin = new Admin({
                    userType: type,
                    name: name,
                    email: email,
                    password: hashedPassword,
                });

                return await saveUser(newAdmin);

            case 'Seller':
                throw new Error('Use sellerSignUp route for Seller sign ups');

            default:
                throw new Error('Invalid user type');

        }



    } catch (error) {
        res.status(500).json(error.message);
        console.log(error);

    }


});

module.exports = router;
