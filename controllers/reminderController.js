const asyncHandler = require('express-async-handler');
const Reminder = require('../models/reminder');

//@desc add a reminder
//@route POST /api/reminder/add/
//@access private
const addReminder = asyncHandler(async(req,res)=>{
    const { title, description, remindDate, patientID } = req.body;

    try {
        // Create a new reminder document
        const reminder = await Reminder.create({
            title,
            description,
            remindDate,
            patientID
        });

        res.status(201).json({ success: true, data:reminder });
    } catch (error) {
        console.error("Failed to add reminder:", error);
        res.status(400).json({ success: false, message: "Failed to add reminder" });
    }
});

//@desc update a reminder
//@route PUT /api/reminder/update/:id
//@access private
const updateReminder = asyncHandler(async (req, res) => {
    const { id } = req.params;
    const { title, description, remindDate, patientID } = req.body;

    const reminder = await Reminder.findByIdAndUpdate(id, {
        title,
        description,
        remindDate,
        patientID
    }, { new: true });

    if (!reminder) {
        return res.status(404).json({ success: false, message: "Reminder not found" });
    }

    res.status(200).json({ success: true, reminder });
});

//@desc delete a reminder
//@route DELETE /api/reminder/delete/:id
//@access private
const deleteReminder = asyncHandler(async (req, res) => {
    const { id } = req.params;

    const reminder = await Reminder.findByIdAndDelete(id);

    if (!reminder) {
        return res.status(404).json({ success: false, message: "Reminder not found" });
    }
    res.status(200).json({ success: true, message: "Reminder deleted successfully" });
});

//@desc get all reminders
//@route GET /api/reminder/get/
//@access private
const getAllReminders = asyncHandler(async (req, res) => {
    const reminders = await Reminder.find({});
    if(!reminders){
        res.status(404).json({ success: false, message:"No any reminders"});
    }
    res.status(200).json({ success: true, data:reminders });
});

//@desc get reminder by id
//@route GET /api/reminder/get/:id
//@access private
const getReminderById = asyncHandler(async (req, res) => {
    const { id } = req.params;
    const reminder = await Reminder.findById(id);

    if (!reminder) {
        return res.status(404).json({ success: false, message: "Reminder not found" });
    }

    res.status(200).json({ success: true, data:reminder });
});


module.exports = {addReminder, updateReminder, deleteReminder, getAllReminders, getReminderById}