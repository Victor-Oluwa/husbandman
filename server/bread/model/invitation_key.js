const mongoose = require('mongoose');
const constants = require('../constants');

const invitationKeySchema = mongoose.Schema({
    ownerName: { type: String, default: 'none' },
    ownerEmail: { type: String, default: constants.kDefaultTokenEmail, },
    ownerId: { type: String, default: 'none' },
    assigned: { type: Boolean, default: false, },
    value: { type: String, required: true }
});

const InvitationKey = mongoose.model('InvitationKey', invitationKeySchema);
module.exports = InvitationKey;