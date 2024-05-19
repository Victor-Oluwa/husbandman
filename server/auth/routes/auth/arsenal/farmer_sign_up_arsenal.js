const constants = require('../../../constants');
const error = require('../../../error');
const InvitationKey = require("../../../model/invitation_key");

async function findKey(farmerKey) {
    const key = await InvitationKey.findOne({ value: farmerKey });
    console.log('Find Key: ' + farmerKey);


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

async function assignKey(key, email) {
    key.ownerEmail = email;
    key.assigned = true;
}

module.exports = { findKey, assignKey };