const mongoose = require('mongoose');

const childNotificationSchema = new mongoose.Schema({
    subject: { type: String, required: true },
    message: { type: String, required: true },
    timeSent: { type: Date, required: true },
    isRead: { type: Boolean, default: false },
});

const notificationSchema = new mongoose.Schema({
    ownerId: { type: String, required: true },
    unread: { type: Number, required: true },
    childNotification: [childNotificationSchema],
});


module.exports = notificationSchema;
