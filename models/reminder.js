const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const reminderSchema = new Schema({
  title:{
    type:String,
    required:true,
  },
  description:{
    type:String,
    required:true,
  },
  remindDate:{
    type:String,
    required:true,
  },
  patientID:{
     type: Schema.Types.ObjectId, 
     ref: 'User',
    required:true,
  }
}, { timestamps: true , versionKey: false});

module.exports = mongoose.model('Reminder', reminderSchema);
