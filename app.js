const express = require("express");
const cors = require("cors");
const userRouter = require("./routes/userRoutes");
const pharmacyRouter = require("./routes/pharmacyRoutes");
const productRouter = require("./routes/productRoutes");
const orderRouter = require("./routes/orderRoutes");
const cartRouter = require("./routes/cartRoutes");
const prescriptionRouter = require("./routes/prescriptionRoutes");
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
app.use("/api/products", productRouter);
app.use("/api/orders", orderRouter);
app.use("/api/cart", cartRouter);
app.use("/api/prescriptions", prescriptionRouter);
app.use(errorHandler);
app.use('/uploads', express.static(path.join(__dirname, 'uploads')));

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
