const endpoints = require("../../../endpoints");
const express = require('express');
const Buyer = require("../../../model/buyer");
const Seller = require("../../../model/seller");
const Admin = require("../../../model/admin");
const updateUserRoute = express.Router();

updateUserRoute.post(endpoints.UPDATE_USER, async (req, res) => {

    try {
        const { userId, userType, newData, culprit } = req.body;
        let user = await findUserById(userId, userType);
        user = await updateUser(user, culprit, newData);

        await user.save();

        res.status(200).json(user);
    } catch (e) {
        console.log(e);
        res.status(500).json(e.message);
    }

},);

async function findUserById(userId, type) {
    switch (type) {
        case 'Buyer': {
            const buyer = await Buyer.findById(userId);
            if (!buyer) {
                throw new Error('Failed to find buyer by id');
            }
            return buyer;
        }

        case 'Seller': {
            const seller = await Seller.findById(userId);
            if (!seller) {
                throw new Error('Failed to find seller by id');
            }
            return seller;
        }

        case 'Admin': {
            const admin = await Admin.findById(userId);
            if (!admin) {
                throw new Error('Failed to find admin by id');
            }
            return admin;
        }

        default:
            throw new Error('Invalid user type');
    }
}


async function updateUser(user, culprit, newData) {

    const address = {
        fullAddress: newData.fullAddress,
        city: newData.city,
        state: newData.state,
        country: newData.country,
        zipCode: newData.zipCode,
    }

    user[culprit] = address;

    if (!user[culprit]) {
        throw new Error('Failed to update user');
    }

    return user;
}


module.exports = updateUserRoute;