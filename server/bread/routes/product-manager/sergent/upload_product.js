
const express = require('express');
const endpoints = require('../../../endpoints');
const Product = require('../../../model/product');

const route = express.Router();

route.post(endpoints.UPLOAD_PRODUCT, async (req, res) => {

    try {
        const { name, sellerName, sellerEmail, sellerId, video, image,
            quantityAvailable, price, deliveryDate, description,
            measurement, deliveryLocations, category, } = req.body;
        console.log('Measurement:' + measurement);

        let product = new Product({
            name: name,
            video: video,
            images: image,
            sellerName: sellerName,
            sellerEmail: sellerEmail,
            sellerId: sellerId,
            quantityAvailable: quantityAvailable,
            deliveryDate: deliveryDate,
            price: price,
            measurement: measurement,
            description: description,
            deliveryLocations: deliveryLocations,
            category: category,
        });

        product = await product.save();
        res.status(200).json(product);

    } catch (error) {
        console.log(error);
        res.status(500).json(error.message);
    }

});

module.exports = route;