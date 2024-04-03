const mongoose = require("mongoose");
const bcrypt = require('bcryptjs');
const SALT_WORK_FACTOR = 10;

const Schema = mongoose.Schema;

const userSchema = new Schema({
    firstName: {
        type: String,
        required: true,
        trim: true
    },
    lastName: {
        type: String,
        required: true,
        trim: true
    },
    dob: {
        type: Date,
        required: true,
    },
    address: {
        street: {
          type: String,
          required: true,
          trim: true,
        },
        city: {
          type: String,
          required: true,
          trim: true,
        },
        state: {
          type: String,
          required: true,
          trim: true,
        },
        zipCode: {
          type: String,
          required: true,
          trim: true,
        },
    },
    nic: { // Assuming NIC is a unique identifier for each user
        type: String,
        required: true,
        unique: true,
        trim: true
    },
    contactNo: {
        type: String,
        required: true,
        trim: true
    },
    email: {
        type: String,
        required: true,
        unique: true,
        trim: true,
        lowercase: true,
        match: [/\S+@\S+\.\S+/, 'is invalid'] // Simple regex for email validation
    },
    username: {
        type: String,
        required: true,
        unique: true,
        trim: true
    },
    password: {
        type: String,
        required: true
    },
    role: {
        type: String,
        enum: ['patient', 'pharmacist','admin'],
        default: 'patient'
    },
}, { timestamps: true });


module.exports = mongoose.model('User', userSchema);
