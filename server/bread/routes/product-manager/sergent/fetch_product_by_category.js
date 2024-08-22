const express = require('express');
const endpoints = require('../../../endpoints');
const Product = require('../../../model/product');
const mongoose = require('mongoose');


const router = express.Router();

router.post(endpoints.FETCH_PRODUCT_BY_CATEGORY, async (req, res) => {

    try {
        const { limit, fetched, category } = req.body;
        const fetchedProducts = await fetched.map(id => mongoose.Types.ObjectId.createFromHexString(id));

        const products = await Product.aggregate([
            { $match: { _id: { $nin: fetchedProducts }, category: category } },
            { $sample: { size: limit } }
        ]);

        res.status(200).json(products);

    } catch (e) {
        console.log(e.message);
        res.status(500).json(e.message);
    }
});

module.exports = router;