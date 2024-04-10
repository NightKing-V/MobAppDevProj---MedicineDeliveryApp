const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const ordersSchema = new Schema({
    userID:{
        type: mongoose.Schema.Types.ObjectId, 
        ref: 'User', 
        required: true
    },
    product: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Product',
        required: true,
    },
    cost:{
        type:Number,
        required:true,
    },
    qty:{
        type:Number,
        required:true,
        default:1,
    },
    shipping:{
        type:Number,
        required:true,
    },
    status:{
        type:String,
        required:true,
        enum:["processing", "delivering", "delivered"],
        default:"Processing"
    }
},{ timestamps: true , versionKey: false});

module.exports = mongoose.model('Orders', ordersSchema);
