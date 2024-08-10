const mongoose = require('mongoose');

const childCustomerSchema = new mongoose.Schema({
    customerId: { type: String, required: true },
    customerName: { type: String, required: true },
    customerImage: { type: String, required: true },
    customerEmail: { type: String, required: true },
    customerPhone: [],

});

const customerSchema = new mongoose.Schema({
    ownerId: { type: String, required: true },
    childCustomer: [childCustomerSchema]
});


module.exports = customerSchema;
