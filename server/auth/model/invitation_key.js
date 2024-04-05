const mongoose = require('mongoose');
const validating = require('validator');

const invitationKeySchema = mongoose.Schema({
    ownerName: {
        type: String,
        default: 'none',
    },
    ownerEmail: {
        type: String,
        required: true,
        validate: {
            validator: validating.isEmail,
        }
    },
    ownerId: {
        type: String,
        default: 'none'
    },
    assigned: {
        type: Boolean,
        required: true,
    },
    value: {
        type: String,
        required: true,
    }
});

const InvitationKey = mongoose.model('InvitationKey', invitationKeySchema);
module.exports = InvitationKey;