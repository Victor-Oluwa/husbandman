const bcryptjs = require("bcryptjs");
const Buyer = require('../../../model/buyer');
const Farmer = require('../../../model/farmer');
const Admin = require('../../../model/admin');
const error = require('../../../error');
const status = require("../../../status");
const jwt = require('jsonwebtoken');


async function checkIfUserAlreadyExist(email) {

    if (!email) {
        throw new Error(error.BAD_EMAIL);
    }

    let user = await Buyer.findOne({ email: email });

    if (!user) {
        user = await Farmer.findOne({ email: email });
    } else if (user) {
        throw new Error(error.USER_ALREADY_EXIST);
    }

    if (!user) {
        user = await Admin.findOne({ email: email });
    } else if (user) {
        throw new Error(error.USER_ALREADY_EXIST);
    }

    if (user) {
        throw new Error(error.USER_ALREADY_EXIST);
    }

}

async function hashPassword(password) {
    if (!password) {
        throw new Error(error.WRONG_PASSWORD);
    }
    return await bcryptjs.hash(password, 8);
}

async function createJWT(user) {
    let token = jwt.sign({ id: user._id }, process.env.PASSWORD_KEY);
    if (!token) {
        throw new Error(error.JSON_WEB_TOKEN_ERROR);
    }

    return token;
}

function reportError(e, res) {
    console.log(e.message);
    if (e.message == error.USER_ALREADY_EXIST) {
        res.status(status.USER_ALREADY_EXIST).json(e.message);
        return;
    }

    if (e.message == error.USER_DOES_NOT_EXIST) {
        res.status(status.USER_DOES_NOT_EXIST).json(e.message);
        return;
    }

    if (e == error.WRONG_PASSWORD) {
        res.status(status.WRONG_PASSWORD).json(e.message);
        return;
    }

    if (e == error.BAD_EMAIL) {
        res.status(status.BAD_EMAIL).json(e.message);
        return;
    }

    if (e == error.KEY_IS_REGISTERED) {
        res.status(status.KEY_IS_REGISTERED).json(e.message);
        return;
    }

    if (e == error.JSON_WEB_TOKEN_ERROR) {
        res.status(status.JSON_WEB_TOKEN_ERROR).json(e.message);
        return;
    }

    res.status(500).json(e);
}

module.exports = {
    checkIfUserAlreadyExist,
    createJWT,
    reportError,
    hashPassword
};






