const express = require('express');
const cors = require('cors');
const userRouter = require('./routes/userRoutes');
const binRouter = require('./routes/binRoutes');
const connectDB = require('./dbConn');
const errorHandler = require("./middlewares/errorHandler");
const dotenv = require("dotenv").config();
const cron = require('node-cron');
const { generateDailySummaries } = require('./controllers/summaryController');


const app = express();
const port = process.env.PORT || 3000;

// Connect to MongoDB
connectDB()

// Schedule daily summaries generation to run every day at 1:00 AM
cron.schedule('0 1 * * *', () => {
    console.log('Starting daily summary generation...');
    generateDailySummaries().then(() => {
      console.log('Daily summary generation completed.');
    }).catch((error) => {
      console.error('Daily summary generation failed:', error);
    });
  });

app.use(cors());
app.use(express.json()); // Middleware to parse JSON bodies
app.use("/api/users",userRouter);
app.use("/api/bins",binRouter);
app.use(errorHandler);

app.listen(port, () => {
    console.log(`Server running on port ${port}`);
});
