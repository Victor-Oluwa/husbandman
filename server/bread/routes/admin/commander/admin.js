const express = require('express');
const saveInvitationKey = require('../sergent/save_invitation_key');
const fetchAllInvitationKeyRoute = require('../sergent/fetch_all_invitation_token');

const adminRouter = express.Router();

adminRouter.use(saveInvitationKey);
adminRouter.use(fetchAllInvitationKeyRoute);

module.exports = adminRouter;