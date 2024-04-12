const mongoose = require("mongoose");

const Schema = mongoose.Schema;

const pharmacySchema = new Schema(
  {
    pharmacyName: {
      type: String,
      required: true,
    },
    description: {
      type: String,
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
    geoLocation: {
      lat: { type: Number, default: 10 },
      lng: { type: Number, default: 10 }
    },
    images: {
      type: [String],
      required: true,
      default: ['https://example.com/placeholder.jpg']
    },
    owner: {
      type: String,
      required: true,
    },
    ownerID:{
      type: mongoose.Schema.Types.ObjectId, 
      ref: 'User', 
      required: true
    },
    licenseNumber: {
      type: String,
      required: true,
      index: true,
    },
    delivery: {
      type: String,
      required: true,
      default:'Yes'
    },
  },
  { timestamps: true, versionKey:false }
);

module.exports = mongoose.model("Pharmacy", pharmacySchema);
