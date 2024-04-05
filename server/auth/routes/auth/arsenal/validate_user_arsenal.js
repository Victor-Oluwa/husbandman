const error = require('../../../error');
const { jwt } = require('jsonwebtoken');
const Buyer = require('../../../model/buyer');
const Farmer = require('../../../model/farmer');
const Admin = require('../../../model/admin');
const status = require('../../../status');

async function getToken(req) {
    const token = req.header(process.env.AUTH_TOKEN_KEY);
    return token;

}

async function verifyToken(token) {
    if (!token) throw new Error(error.BAD_TOKEN);
    const verified = jwt.verify(token, process.env.PASSWORD_KEY);
    if (!verified) throw new Error(error.BAD_TOKEN);
    let user = await getUser(verified.id);
    user.token = token;
    return user;
}

async function getUser(id) {
    let user = await Buyer.findById(id);

    if (!user) {
        user = await Farmer.findById(id);
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
    }

    res.status(500).json(e);
}

module.exports = { verifyToken, getToken, getUser, reportError };