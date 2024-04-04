const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const productSchema = new Schema({
  name: {
    type: String,
    required: true,
    trim: true
  },
  description: {
    type: String,
    required: true,
    trim: true
  },
  price: {
    type: Number,
    required: true
  },
  category: {
    type: String,
    required: true,
    enum: ['prescription', 'over-the-counter', 'supplement', 'personal care', 'other'],
    default: 'other'
  },
  stockQuantity: {
    type: Number,
    required: true,
    min: [0, 'Stock quantity cannot be less than 0']
  },
  dosageForm: {
    type: String, // E.g., tablet, capsule, liquid, topical, etc.
    required: false
  },
  activeIngredients: [{ // For products with multiple active ingredients
    name: String,
    strength: String // E.g., "500 mg"
  }],
  manufacturer: {
    type: String,
    required: false,
    trim: true
  },
  expiryDate: {
    type: Date,
    required: false
  },
  images: [{ // URLs to images of the product
    type: String
  }]
}, { timestamps: true , versionKey: false});

module.exports = mongoose.model('Product', productSchema);
