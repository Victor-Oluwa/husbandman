const express = require('express');
const endpoints = require('../../../endpoints');
const InvitationKey = require('../../../model/invitation_key');
const error = require('../../../error');
const arsenal = require('../arsenal/validate_invitation_key_arsenal');

const router = express.Router();

router.post(endpoints.VALIDATE_FARMER_INVITATION_KEY, async (req, res) => {
    try {
        const { invitationKey } = req.body;

        const key = await arsenal.validateKey(invitationKey);

        res.status(200).json(key);

    } catch (e) {
        arsenal.reportError(e, res);
    }
});

module.exports = router;


