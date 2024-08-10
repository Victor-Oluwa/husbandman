const mongoose = require('mongoose');

const adminSchema = new mongoose.Schema({
    userType: { type: String, required: true },
    name: { type: String, required: true },
    email: { type: String, required: true },
    password: { type: String, required: true },
    profilePicture: { type: String, default: '' },
    lastSeen: { type: String, default: '' },
});
const Admin = mongoose.model('Admin', adminSchema);
module.exports = Admin;