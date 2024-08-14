const error = require("../../../error");
const InvitationKey = require("../../../model/invitation_key");
const status = require("../../../status");



async function saveKey(key) {
    let newKey = new InvitationKey({
        value: key,
    });

    return newKey;
}

async function checkForDuplicate(key) {
    const duplicate = await InvitationKey.findOne({ value: key });

    if (!duplicate) {
        return false;
    }
    return true;
}



module.exports = { saveKey, checkForDuplicate };
