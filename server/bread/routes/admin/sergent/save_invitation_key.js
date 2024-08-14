const express = require('express');
const endpoints = require('../../../endpoints');
const InvitationKey = require('../../../model/invitation_key');
const error = require('../../../error');
const status = require('../../../status');
const arsenal = require('../arsenal/save_invitation_key_arsenal');

const router = express.Router();

router.post(endpoints.SAVE_INVITATION_TOKEN, async (req, res) => {
    try {
        const { key } = req.body;
        let duplicate = await arsenal.checkForDuplicate(key);

        if (duplicate == false) {
            let newKey = await arsenal.saveKey(key);

            newKey = await newKey.save();

            res.status(200).json('Key saved successfully');
        } else {
            throw new Error(error.DUPLICATE_INVITATION_KEY)
        }

    } catch (e) {
        console.log(e);
        res.status(500).json(e.message);
    }
});


module.exports = router;
