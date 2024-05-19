
const express = require('express');
const endpoints = require('../../../endpoints');
const Product = require('../../../model/product');

const route = express.Router();

route.post(endpoints.UPLOAD_PRODUCT, async (req, res) => {

    try {
        const { name, video, image, sellerName, sellerEmail, quantity, price, description, deliveryLocation, } = req.body;

        let product = new Product({
            name: name,
            video: video,
            images: image,
            sellerName: sellerName,
            sellerEmail: sellerEmail,
            quantity: quantity,
            price: price,
            description: description,
            deliveryLocations: deliveryLocation,
        });

        product = await product.save();
        res.status(200).json(product);

    } catch (error) {
        console.log(error);
        res.status(500).json(error.message);
    }

});

module.exports = route;