const constants = require('../../../constants');
const error = require('../../../error');
const InvitationKey = require("../../../model/invitation_key");

async function findKey(farmerKey, session) {
    const key = await InvitationKey.findOne({ value: farmerKey }).session(session);
    console.log('Found Key: ' + farmerKey);


    if (!key) {
        throw new Error(error.INVALID_KEY);
    }

    if (key.ownerEmail != constants.kDefaultTokenEmail) {
        throw new Error(error.USED_KEY);
    }

    if (key.assigned == true) {
        throw new Error(error.USED_KEY);
    }

    return key;
}

async function assignKey(key, email, name, session) {
    key.ownerName = name,
        key.ownerEmail = email;
    key.assigned = true;

    return key;
}

module.exports = { findKey, assignKey };