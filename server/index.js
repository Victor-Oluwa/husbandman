require('dotenv').config();
const express = require('express');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const mongoose = require('mongoose');
const cors = require('cors');
const authRouter = require('./auth/routes/auth/commander/auth');
const adminRouter = require('./auth/routes/admin/commander/admin');

//IMPORTS FROM OTHER FILES

//INIT
const app = express();

//Middleware
app.use(express.json());
// app.use(cors(
//     { origin: 'https://192.168.141.1:3000' }
// ));
app.use(cors());
app.use(authRouter);
app.use(adminRouter);

//Connections
mongoose.connect(process.env.MONGODB_URI, {
}).then(() => console.log("Connected to MongoDB"))
    .catch(err => console.error("Could not connect to mongoDB..", err));

app.listen(process.env.PORT, () => {
    console.log(`Server running at http://localhost:${process.env.PORT}`);
});
