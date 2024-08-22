// Imports
const express = require('express');

const signIn = require('../sergents/sign_in');
const validateUser = require('../sergents/validate_user');
const validateInvitationKey = require('../sergents/validate_invitation_key');
const farmer_sign_up = require('../sergents/farmer_sign_up');
const signUp = require('../sergents/sign_up');
const updateUserRoute = require('../sergents/update_user');

const authRouter = express.Router();

//Sergents
authRouter.use(signIn);
authRouter.use(signUp);
authRouter.use(farmer_sign_up)
authRouter.use(validateUser);
authRouter.use(validateInvitationKey);
authRouter.use(updateUserRoute);

// Export File
module.exports = authRouter;

