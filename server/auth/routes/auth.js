const express = require('express');
const authMW = require('../middlewere/auth_middlewere');
const authRouter = express.Router();

authRouter.post('/auth/buyer/signUp', authMW, async (req, res) => { });

authRouter.post('/auth/farmer/signUp', authMW, async (req, res) => { });



module.exports = authRouter;