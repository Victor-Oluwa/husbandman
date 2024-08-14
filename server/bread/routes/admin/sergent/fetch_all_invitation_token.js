const express = require('express');
const InvitationKey = require('../../../model/invitation_key');
const endpoints = require('../../../endpoints');

const fetchAllInvitationKeyRoute = express.Router();

fetchAllInvitationKeyRoute.get(endpoints.FETCH_ALL_INVITATION_TOKEN, async (req, res) => {
    try {
        const invKeys = await InvitationKey.find();
        if (!invKeys) {
            throw new Error('No invitation key found');
        }
        return res.status(200).json(invKeys);
    } catch (e) {
        console.log(e);
        res.status(500).json(e.message);
    }


},);

module.exports = fetchAllInvitationKeyRoute;