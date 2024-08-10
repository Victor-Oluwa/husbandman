const express = require('express');
const endpoints = require('../../../endpoints');
const Order = require('../../../model/order');

const createOrderRoute = express.Router();

createOrderRoute.post(endpoints.CREATE_ORDER, async (req, res) => {
    console.log('Hello');
    try {
        const order = req.body;
        console.log('Orderrr: ' + order);
        console.log('Order ID: ' + order.ownerId);


        const orderEntityExist = await checkIfAnOrderEntityExist(order.ownerId);

        if (orderEntityExist) {
            console.log(`Updating order`);
            let updatedOrder = await addNewOrder(order);
            updatedOrder = await updatedOrder.save();
            return res.status(200).json(updatedOrder);
        } else {
            console.log(`Creating order`);

            let newOrder = await createOrder(order);
            newOrder = await newOrder.save();
            return res.status(200).json(newOrder);
        }
    } catch (e) {
        console.error(e);
        return res.status(500).json(e.message);
    }
});

async function checkIfAnOrderEntityExist(ownerId) {
    const orderExist = await Order.findOne({ ownerId });
    return !!orderExist;
}

async function createOrder(order) {
    const newOrder = new Order({
        ownerId: order.ownerId,
        grandTotal: order.grandTotal,
        orders: order.orders,
    });
    return newOrder;
}

async function addNewOrder(order) {
    const existingOrder = await Order.findOne({ ownerId: order.ownerId });
    if (existingOrder) {
        const newOrder = {
            grossTotal: order.orders[0].grossTotal,
            orderName: order.orders[0].orderName,
            orderItems: order.orders[0].orderItems,
        };
        existingOrder.orders.push(newOrder);
        return existingOrder;
    }
    throw new Error('Order entity does not exist for the provided ownerId');
}
module.exports = createOrderRoute;