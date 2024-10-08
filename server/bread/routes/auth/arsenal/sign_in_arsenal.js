const bcryptjs = require("bcryptjs");
const Buyer = require('../../../model/buyer');
const Admin = require('../../../model/admin');
const error = require('../../../error');
const status = require("../../../status");
const InvitationKey = require("../../../model/invitation_key");
const Seller = require("../../../model/seller");

async function checkIfUserIsRegistered(email) {
    if (!email) {
        throw new Error(error.BAD_EMAIL);
    }
    let user = await Buyer.findOne({ email: email });
    if (!user) {
        user = await Seller.findOne({ email: email });
    }

    if (!user) {
        user = await Admin.findOne({ email: email });
    }

    if (!user) {
        throw new Error(error.USER_DOES_NOT_EXIST);
    }

    return user;
}

async function verifySellerToken(email) {
    let seller = await Seller.findOne({ email: email });
    if (!seller) {
        console.log('User is not a seller');
        return;
    }

    let key = await InvitationKey.findOne({ ownerEmail: email });
    if (!key) {
        throw new Error(error.NO_KEY_ASSIGNED);
    }
    console.log('User has the key: ' + key);
}

async function verifyPassword(password, user) {
    const isMatch = await bcryptjs.compare(password, user.password);
    if (!isMatch) {
        throw new Error(error.WRONG_PASSWORD);
    }

    return isMatch;
}

function reportError(e, res) {
    console.log(e.message);

    if (e.message == error.USER_ALREADY_EXIST) {
        res.status(status.USER_ALREADY_EXIST).json(e.message);
        return;

    }

    if (e.message == error.USER_DOES_NOT_EXIST) {
        res.status(status.USER_DOES_NOT_EXIST).json(e.message);
        console.log('My bad: ' + e.message);
        return;

    }

    if (e.messsage == error.WRONG_PASSWORD) {
        res.status(status.WRONG_PASSWORD).json(e.message);
        return;

    }

    if (e.message == error.BAD_EMAIL) {
        res.status(status.BAD_EMAIL).json(e.message);
        return;

    }

    if (e.message == error.INVALID_KEY) {
        res.status(status.INVALID_KEY).json(e.message);
        return;

    }

    if (e.message == error.JSON_WEB_TOKEN_ERROR) {
        res.status(status.JSON_WEB_TOKEN_ERROR).json(e.message);
        return;

    }

    if (e.message == error.NO_KEY_ASSIGNED) {
        res.status(status.NO_KEY_ASSIGNED).json(e.message);
        return;

    }
    res.status(500).json(e);
}

module.exports = {
    checkIfUserIsRegistered,
    verifyPassword,
    reportError,
    verifySellerToken,
}