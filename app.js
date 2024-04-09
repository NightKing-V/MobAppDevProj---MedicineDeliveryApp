const express = require("express");
const cors = require("cors");
const userRouter = require("./routes/userRoutes");
const pharmacyRouter = require("./routes/pharmacyRoutes");
const connectDB = require("./dbConn");
const errorHandler = require("./middlewares/errorHandler");
const dotenv = require("dotenv").config();
const cron = require("node-cron");
const path = require('path');

const app = express();
const port = process.env.PORT || 3000;

// Connect to MongoDB
connectDB();

app.use(cors());
app.use(express.json()); // Middleware to parse JSON bodies
app.use("/api/users", userRouter);
app.use("/api/pharmacies", pharmacyRouter);
app.use(errorHandler);
app.use('/uploads', express.static(path.join(__dirname, 'uploads')));

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
