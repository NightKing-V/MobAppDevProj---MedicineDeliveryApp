const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const productSchema = new Schema({
    userID:{
        type: mongoose.Schema.Types.ObjectId, 
        ref: 'User', 
        required: true
    },
    ProductID:{
        tye:mongoose.Schema.Types.ObjectId,
        ref:'Product',
        required:true,
    }
},{ timestamps: true , versionKey: false});

module.exports = mongoose.model('PurchaseHistory', productSchema);
