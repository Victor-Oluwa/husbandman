
const error = require('../../../error');
const status = require('../../../status');
const PaymentCard = require('../../../model/payment_card');


async function deleteCard(cardId) {
    let card = await PaymentCard.findById(cardId);
    if (!card) {
        throw new Error(error.CARD_NOT_FOUND);
    }
    await PaymentCard.findByIdAndDelete(cardId);
}

function reportError(e, res) {
    if (e.message == error.CARD_NOT_FOUND) {
        res.status(status.CARD_NOT_FOUND).json(e.message);
        return;
    }

    console.log(e);
    res.status(500).json(e);
}

module.exports = { reportError, deleteCard }
