const error = require('../../../error');
const Buyer = require('../../../model/buyer');
const Admin = require('../../../model/admin');
const status = require('../../../status');
const jwt = require('jsonwebtoken');
const Seller = require('../../../model/seller');

async function getToken(req) {
    // console.log('Hahha' + process.env.AUTH_TOKEN_KEY)
    const token = req.header(process.env.AUTH_TOKEN_KEY);
    if (!token) {
        throw new Error(error.BAD_TOKEN);
    }
    return token;

}

async function verifyToken(token) {
    if (!token) throw new Error(error.BAD_TOKEN);
    const verified = jwt.verify(token, process.env.PASSWORD_KEY);
    if (!verified) throw new Error(error.BAD_TOKEN);
    let user = await getUser(verified.id);
    if (!user) throw new Error(error.USER_DOES_NOT_EXIST);
    user.token = token;
    return user;
}

async function getUser(id) {
    let user = await Buyer.findById(id);

    if (!user) {
        user = await Seller.findById(id);
    }

    if (!user) {
        user = await Admin.findById(id);
    }

    if (!user) {
        throw new Error(error.BAD_TOKEN);
    }

    return user;
}

function reportError(e, res) {
    console.log(e.message);

    if (e.message == error.BAD_TOKEN) {
        res.status(status.BAD_TOKEN).json(e.message);
        return;
    }
    console.log(e);

    res.status(500).json(e);
}

module.exports = { verifyToken, getToken, getUser, reportError };