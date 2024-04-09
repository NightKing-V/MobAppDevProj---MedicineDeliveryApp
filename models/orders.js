const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const ordersSchema = new Schema({
    userID:{
        type: mongoose.Schema.Types.ObjectId, 
        ref: 'User', 
        required: true
    },
    products: [{
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Product',
        required: true,
    }],
    cost:{
        type:Number,
        required:true,
    },
    shipping:{
        type:Number,
        required:true,
    },
    status:{
        type:String,
        required:true,
        enum:["Processing", "Delivering", "Delivered"],
        default:"Processing"
    }
},{ timestamps: true , versionKey: false});

module.exports = mongoose.model('Orders', ordersSchema);
