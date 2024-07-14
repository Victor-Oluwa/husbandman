const error = require('../../../error');
const PaymentCard = require('../../../model/payment_card');
const status = require('../../../status');

async function fetchCards(ownerId) {
    const allCards = await PaymentCard.find({ ownerId: ownerId });

    if (!allCards) {
        throw new Error(error.FAILED_TO_FETCH_CARD);
    }

    return allCards;

}

function reportError(e, res) {
    if (e.message == error.FAILED_TO_FETCH_CARD) {
        res.status(status.FAILED_TO_FETCH_CARD).json(e.message);
        return;
    }

    console.log(e);
    res.status(500).json(e);
}

module.exports = { fetchCards, reportError }