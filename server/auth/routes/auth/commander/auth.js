// Imports
const express = require('express');

const signIn = require('../sergents/sign_in');
const buyerSignUp = require('../sergents/buyer_sign_up');
const validateUser = require('../sergents/validate_user');
const validateInvitationKey = require('../sergents/validate_invitation_key');
const farmer_sign_up = require('../sergents/farmer_sign_up');

const authRouter = express.Router();

//Sergents
authRouter.use(signIn);
authRouter.use(buyerSignUp);
authRouter.use(farmer_sign_up)
authRouter.use(validateUser);
authRouter.use(validateInvitationKey);

// Export File
module.exports = authRouter;

