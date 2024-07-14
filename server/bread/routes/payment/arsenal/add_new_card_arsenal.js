const error = require('../../../error');
const status = require('../../../status');
const PaymentCard = require('../../../model/payment_card');

async function checkIfCardExist(cardNumber) {
    let card = await PaymentCard.findOne({ cardNumber: cardNumber });

    if (card) {
        throw new Error('You have added this card already');
    }
}

async function addCard(type, ccv, expiryDate, holderName, cardNumber, ownerId,) {
    const newCard = PaymentCard(
        {
            type: type,
            ccv: ccv,
            expiryDate: expiryDate,
            holderName: holderName,
            number: cardNumber,
            ownerId: ownerId,
            label: 'Secondary'
        }
    );

    return newCard;
}

function reportError(e, res) {
    if (e.message == error.CARD_ALREADY_ADDED) {
        res.status(status.CARD_ALREADY_ADDED).json(e.message);
        return;
    }

    console.log(e);
    res.status(500).json(e);
}


module.exports = { checkIfCardExist, addCard, reportError }