require('dotenv').config();
const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const authRouter = require('./bread/routes/auth/commander/auth');
const adminRouter = require('./bread/routes/admin/commander/admin');
const productManagerRouter = require('./bread/routes/product-manager/commander/product_manager');
const cartRoute = require('./bread/routes/cart/commander/cart');
const paymentRoute = require('./bread/routes/payment/commandar/payment');
const orderRoute = require('./bread/routes/order/commander/order');

//IMPORTS FROM OTHER FILES

//INIT
const app = express();

//Middleware
app.use(express.json());
app.use(cors());
app.use(authRouter);
app.use(adminRouter);
app.use(productManagerRouter);
app.use(cartRoute);
app.use(paymentRoute);
app.use(orderRoute);

//Connections
mongoose.connect(process.env.MONGODB_URI, {
}).then(() => console.log("Connected to MongoDB"))
    .catch(err => console.error("Could not connect to mongoDB..", err));

app.listen(process.env.PORT, () => {
    console.log(`Server running at http://localhost:${process.env.PORT}`);
});
