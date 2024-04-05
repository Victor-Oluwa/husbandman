const bcryptjs = require("bcryptjs");
const Buyer = require('../../../model/buyer');
const Farmer = require('../../../model/farmer');
const Admin = require('../../../model/admin');
const error = require('../../../error');
const status = require("../../../status");

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
    return jwt.sign({ id: user._id }, process.env.PASSWORD_KEY);
}

function reportError(e, res) {
    console.log(e.message);
    if (e.message == error.USER_ALREADY_EXIST) {
        res.status(status.USER_ALREADY_EXIST).json(e.message);
    }

    if (e.message == error.USER_DOES_NOT_EXIST) {
        res.status(status.USER_DOES_NOT_EXIST).json(e.message);
    }

    if (e == error.WRONG_PASSWORD) {
        res.status(status.WRONG_PASSWORD).json(e.message);
    }

    if (e == error.BAD_EMAIL) {
        res.status(status.BAD_EMAIL).json(e.message);
    }

    if (e == error.KEY_IS_REGISTERED) {
        res.status(status.KEY_IS_REGISTERED).json(e.message);
    }

    res.status(500).json(e);
}

module.exports = {
    checkIfUserAlreadyExist,
    createJWT,
    reportError,
    hashPassword
};






