const express = require('express');
const addNewCardRouter = require('../sergent/add_new_card');
const deleteCardRoute = require('../sergent/delete_card');
const fetchAllCardsRoute = require('../sergent/fetch_all_cards');
const initCardFundingRoute = require('../sergent/card_funding/initialize_card_funding');
const cardFundingOtpValidationRoute = require('../sergent/card_funding/card_funding_otp_validation');
const cardFundingPinAuthRoute = require('../sergent/card_funding/card_funding_pin_authentication');
const cardFundingAddressAuthRoute = require('../sergent/card_funding/card_funding_address_authentication');
const cardFundingVerificationRoute = require('../sergent/card_funding/card_funding_verification');

const paymentRoute = express.Router();

paymentRoute.use(addNewCardRouter)
paymentRoute.use(deleteCardRoute);
paymentRoute.use(fetchAllCardsRoute);
paymentRoute.use(initCardFundingRoute);
paymentRoute.use(cardFundingOtpValidationRoute);
paymentRoute.use(cardFundingPinAuthRoute);
paymentRoute.use(cardFundingAddressAuthRoute);
paymentRoute.use(cardFundingVerificationRoute);



module.exports = paymentRoute;