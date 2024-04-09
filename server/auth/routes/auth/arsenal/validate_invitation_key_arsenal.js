
const InvitationKey = require('../../../model/invitation_key');
const error = require('../../../error');
const status = require('../../../status');



async function validateKey(invitationKey) {
    const key = await InvitationKey.findOne({ value: invitationKey });

    if (!key) {
        throw new Error(error.INVALID_KEY);
    }

    if (key.assigned == true) {
        throw new Error(error.KEY_IS_REGISTERED);
    }

    return key;
};

function reportError(e, res) {
    console.log(e.message);

    if (e.message == error.INVALID_KEY) {
        res.status(status.INVALID_KEY).json(e.message);
        return;

    }

    if (e.message == error.KEY_IS_REGISTERED) {
        res.status(status.KEY_IS_REGISTERED).json(e.message);
        return;

    }

    res.status(500).json(e.message);
}

module.exports = { validateKey, reportError };