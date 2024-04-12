const error = require('../../../error');
const InvitationKey = require("../../../model/invitation_key");

async function findKey(key) {
    const exist = await InvitationKey.findOne({ value: key });

    if (!exist) {
        throw new Error(error.INVALID_KEY);
    }
    return key;
}

async function assignKey(key, email) {
    key.ownerEmail = email;
    key.assigned = true;
}

module.exports = { findKey, assignKey };