const express = require('express');
const endpoints = require('../../../endpoints');
const Product = require('../../../model/product');

const router = express.Router();

router.post(endpoints.FETCH_ALL_PRODUCTS, async (req, res) => {

    try {
        const { limit, fetched } = req.body;

        const products = await Product.aggregate([
            { $match: { _id: { $nin: fetched.map(id => mongoose.Types.ObjectId(id)) } } },
            { $sample: { size: limit } }
        ]);

        res.status(200).json(products);

    } catch (e) {
        res.status(500).json(e.message);
    }
});

module.exports = router;

// const products = await Product.aggregate([{ $sample: { size: limit } }]);