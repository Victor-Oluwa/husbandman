const express = require('express');
const endpoints = require('../../../endpoints');
const Order = require('../../../model/order');
const Seller = require('../../../model/seller');
const Buyer = require('../../../model/buyer');
const mongoose = require('mongoose');
const Product = require('../../../model/product');

const createOrderRoute = express.Router();

createOrderRoute.post(endpoints.CREATE_ORDER, async (req, res) => {
    const session = await mongoose.startSession();
    session.startTransaction();

    try {
        let order = req.body;


        const existingOrder = await getExistingOrder(order.ownerId, session);
        let newOrder = await placeOrder(existingOrder, order, session);
        await updateProductQuantity(order, session)

        await updateSellerOrderedItems(order, session);
        await updateSellerPendingOrderFunds(order, session);
        await updateBuyerPendingFunds(order, session);

        //Delete user cart

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

    order.orders.forEach(singleOrder => {
        if (!singleOrder._id) singleOrder._id = new mongoose.Types.ObjectId();
        singleOrder.orderItems.forEach(item => {
            if (!item._id) item._id = new mongoose.Types.ObjectId();
        });
    });

    const newOrder = new Order({
        ownerId: order.ownerId,
        grandTotal: order.grandTotal,
        orders: order.orders,
    });

    await newOrder.save({ session });

    return newOrder;
}


async function addNewOrder(existingOrder, order, session) {

    order.orders.forEach(singleOrder => {
        if (!singleOrder._id) singleOrder._id = new mongoose.Types.ObjectId();
        singleOrder.orderItems.forEach(item => {
            if (!item._id) item._id = new mongoose.Types.ObjectId();
        });
    });

    const newOrderData = {
        grossTotal: order.orders[0].grossTotal,
        orderName: order.orders[0].orderName,
        totalPercentage: order.orders[0].totalPercentage,
        orderItems: order.orders[0].orderItems,
    };

    existingOrder.orders.push(newOrderData);
    await existingOrder.save({ session });

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
    let orderItems = order.orders[0].orderItems;
    for (const item of orderItems) {

        const amountPending = item.itemPrice - item.deductible;

        let seller = await Seller.findById(item.sellerId).session(session);
        if (!seller) {
            throw new Error(`Failed to find seller with ID: ${item.sellerId}`);
        }

        let fund = {
            buyerId: item.buyerId,
            productId: item.itemId,
            productName: item.itemName,
            amountPending: amountPending,
        }

        if (!seller.pendingOrderFunds) {
            console.log('Creating new pending order funds');
            seller.pendingOrderFunds = {
                funds: [fund]
            }
        } else {
            console.log('Updating pending order funds');
            seller.pendingOrderFunds.funds.push(fund);

        }

        await seller.save({ session });

    };


}

async function updateProductQuantity(order, session) {
    console.log('Updating product quantity');
    let orderItems = order.orders[0].orderItems;

    for (const item of orderItems) {
        let product = await Product.findById(item.itemId).session(session);

        if (!product) {
            throw new Error('Failed to find product by id while processing order');
        }

        const deductable = product.quantityAvailable -= item.itemQuantity;

        if (deductable >= 1) {
            let newQuantity = (product.quantityAvailable -= item.itemQuantity);

            if (newQuantity < 1) {
                product.isLive = false;
            }
        } else {

        }


        await product.save({ session });
    }

}

async function updateBuyerPendingFunds(order, session) {
    const orderItems = order.orders[0].orderItems;

    let buyer = await Buyer.findById(orderItems[0].buyerId).session(session);

    if (!buyer) {
        buyer = await Seller.findById(orderItems[0].buyerId).session(session);

        if (!buyer) {
            throw new Error('Failed to find buyer by ID');

        }
    }


    for (const item of orderItems) {

        let payment = {
            sellerId: item.sellerId,
            orderName: order.orders[0].orderName,
            productId: item.itemId,
            sellerName: item.sellerName,
            timeStamp: new Date(),
            productName: item.itemName,
            productPrice: item.itemPrice,
        }

        if (!buyer.pendingPayment) {
            console.log('Creating new pending payment');
            buyer.pendingPayment = {
                payments: [payment]
            }
        } else {
            console.log('Updating pending payment');
            buyer.pendingPayment.payments.push(payment);
        }

        await buyer.save({ session });

    }

}

async function updateSellerOrderedItems(order, session) {

    const orderItems = order.orders[0].orderItems;

    for (const item of orderItems) {
        // Fetch the seller and buyer using their IDs
        const seller = await Seller.findById(item.sellerId).session(session);
        if (!seller) {
            throw new Error(`Failed to find seller with ID: ${item.sellerId}`);
        }

        let buyer = await Buyer.findById(item.buyerId).session(session);
        if (!buyer) {
            buyer = await Seller.findById(item.buyerId).session(session);
            if (!buyer) {
                throw new Error(`Failed to find buyer with ID: ${item.buyerId}`);

            }
        }


        let orderedItem = {
            buyerId: item.buyerId,
            buyerName: buyer.name,
            buyerImage: buyer.image,
            buyerEmail: buyer.email,
            buyerAddress: buyer.address,
            productName: item.itemName,
            productImage: item.itemImage,
            productPrice: item.itemPrice,
            deductible: item.deductible,
            productQuantity: item.itemQuantity,
            productDeliveryDate: item.itemDeliveryDate,
            isItemDelivered: item.isItemDelivered
        }

        const totalEarning = item.itemPrice - item.deductible;

        // If seller's ordered data doesn't exist, initialize it
        if (!seller.ordered) {
            console.log('Creating new ordered data');
            seller.ordered = {
                totalEarning: totalEarning,
                totalDeductible: item.deductible,
                orderedItems: [orderedItem],
            };

        } else {
            console.log('Update existing ordered data');

            // Update existing ordered data
            seller.ordered.totalEarning += totalEarning;
            seller.ordered.totalDeductible += item.deductible;
            seller.ordered.orderedItems.push(orderedItem);
        }

        // Save the updated seller document in the session
        await seller.save({ session });
    }


}

module.exports = createOrderRoute;
