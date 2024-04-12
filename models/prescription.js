const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const prescriptionSchema = new Schema({
    userID:{
        type: mongoose.Schema.Types.ObjectId, 
        ref: 'User', 
        required: true
    },
    prescriptionImage: {
        type: String,
        required: true,
    },
    pickedup:{
        type:String,
        required:true,
        default:"Awaiting to Pickup",
    }
    
},{ timestamps: true , versionKey: false});

module.exports = mongoose.model('Prescription', prescriptionSchema);
