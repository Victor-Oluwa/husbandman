const express = require('express');
const saveInvitationKey = require('../sergent/save_invitation_key');

const adminRouter = express.Router();

adminRouter.use(saveInvitationKey);


module.exports = adminRouter;