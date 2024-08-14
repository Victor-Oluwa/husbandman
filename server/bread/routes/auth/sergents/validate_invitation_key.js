const express = require('express');
const endpoints = require('../../../endpoints');
const arsenal = require('../arsenal/validate_invitation_key_arsenal');

const router = express.Router();

router.post(endpoints.VALIDATE_FARMER_INVITATION_KEY, async (req, res) => {
    try {
        const { invitationKey } = req.body;

        const key = await arsenal.validateKey(invitationKey);
        console.log('Validated key: ' + key);

        res.status(200).json(key);

    } catch (e) {
        console.log(e);
        res.status(500).json(e.message);
    }
});

module.exports = router;


