const express = require('express');
const endpoints = require('../../../endpoints');
const Order = require('../../../model/order');
const Seller = require('../../../model/seller');
const Buyer = require('../../../model/buyer');
const mongoose = require('mongoose');

const createOrderRoute = express.Router();

createOrderRoute.post(endpoints.CREATE_ORDER, async (req, res) => {
    const session = await mongoose.startSession();
    session.startTransaction();

    try {
        const order = req.body;

        const existingOrder = await getExistingOrder(order.ownerId, session);
        let newOrder = await placeOrder(existingOrder, order, session);

        let seller = await updateSellerOrderedItems(order, session);
        seller = await updateSellerPendingOrderFunds(order, session);

        await newOrder.save({ session });
        await seller.save({ session });

        await session.commitTransaction();
        session.endSession();

        res.status(200).json(newOrder);

    } catch (e) {
        await session.abortTransaction();
        session.endSession();
        console.error(e);
        return res.status(500).json({ error: e.message });
    }
});

async function getExistingOrder(ownerId, session) {
    return await Order.findOne({ ownerId }).session(session);
}

async function createOrder(order, session) {
    const newOrder = new Order({
        ownerId: order.ownerId,
        grandTotal: order.grandTotal,
        orders: order.orders,
    });
    return newOrder;
}

async function addNewOrder(existingOrder, order, session) {
    const newOrderData = {
        grossTotal: order.orders[0].grossTotal,
        orderName: order.orders[0].orderName,
        orderItems: order.orders[0].orderItems,
    };
    existingOrder.orders.push(newOrderData);
    return existingOrder;
}

async function placeOrder(existingOrder, order, session) {
    if (existingOrder) {
        console.log(`Updating order`);
        return await addNewOrder(existingOrder, order, session);
    } else {
        console.log(`Creating order`);
        return await createOrder(order, session);
    }
}

async function updateSellerPendingOrderFunds(order, session) {
    let orderItem = order.orders[0].orderItems[0];
    const amountPending = orderItem.itemPrice - orderItem.deductible;

    let seller = await Seller.findById(orderItem.sellerId).session(session);
    if (!seller) {
        throw new Error('Failed to find seller by ID');
    }

    let fund = {
        buyerId: orderItem.buyerId,
        productId: orderItem.itemId,
        productName: orderItem.itemName,
        amountPending: amountPending,
    }

    seller.pendingOrderFunds.funds.push(fund);
    return seller;
}

async function updateSellerOrderedItems(order, session) {
    const orderItem = order.orders[0].orderItems[0];

    let seller = await Seller.findById(orderItem.sellerId).session(session);
    let buyer = await Buyer.findById(orderItem.buyerId).session(session);

    if (!seller) {
        throw new Error('Failed to find seller by ID');
    }

    if (!buyer) {
        throw new Error('Failed to find buyer by ID');
    }

    let orderedItem = {
        buyerId: orderItem.buyerId,
        buyerName: buyer.name,
        buyerImage: buyer.image,
        buyerEmail: buyer.email,
        buyerAddress: buyer.address,
        productName: orderItem.itemName,
        productImage: orderItem.itemImage,
        productPrice: orderItem.itemPrice,
        deductable: orderItem.deductible,
        productQuantity: orderItem.itemQuantity,
        productDeliveryDate: orderItem.itemDeliveryDate,
        isItemDelivered: orderItem.isItemDelivered
    }

    seller.ordered.orderedItems.push(orderedItem);

    return seller;
}

module.exports = createOrderRoute;
