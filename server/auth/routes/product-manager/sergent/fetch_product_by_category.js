const express = require('express');
const endpoints = require('../../../endpoints');
const Product = require('../../../model/product');
const mongoose = require('mongoose');


const router = express.Router();

router.post(endpoints.FETCH_PRODUCT_BY_CATEGORY, async (req, res) => {

    try {
        const { limit, fetched, category } = req.body;
        console.log('fff' + fetched);
        console.log('lll' + limit);
        console.log('ccc' + category);

        const fetchedProducts = await fetched.map(id => mongoose.Types.ObjectId.createFromHexString(id));
        // const fetchedProducts = fetched
        console.log('Check 2');


        const products = await Product.aggregate([
            { $match: { _id: { $nin: fetchedProducts }, type: category } },
            { $sample: { size: limit } }
        ]);
        console.log('Check 2');

        res.status(200).json(products);

        console.log('ppp' + products);

    } catch (e) {
        console.log(e.message);
        res.status(500).json(e.message);
    }
});

module.exports = router;