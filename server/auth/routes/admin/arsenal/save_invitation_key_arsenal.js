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

function reportError(e, res) {
    console.log(e.message);

    if (e.message == error.DUPLICATE_INVITATION_KEY) {
        res.status(status.DUPLICATE_INVITATION_KEY).json(e.message);
    }

    res.status(500).json(e);
}

module.exports = { saveKey, checkForDuplicate, reportError };
