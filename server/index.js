require('dotenv').config();
const express = require('express');
// const bcrypt = require('bcryptjs');
// const jwt = require('jsonwebtoken');
const mongoose = require('mongoose');
const cors = require('cors');
const authRouter = require('./auth/routes/auth/commander/auth');
const adminRouter = require('./auth/routes/admin/commander/admin');
const productManagerRouter = require('./auth/routes/product-manager/commander/product_manager');
const cartRoute = require('./auth/routes/cart/commander/cart');

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

//Connections
mongoose.connect(process.env.MONGODB_URI, {
}).then(() => console.log("Connected to MongoDB"))
    .catch(err => console.error("Could not connect to mongoDB..", err));

app.listen(process.env.PORT, () => {
    console.log(`Server running at http://localhost:${process.env.PORT}`);
});
