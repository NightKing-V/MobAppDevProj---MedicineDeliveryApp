const jwt = require('jsonwebtoken');
const User = require("../models/user");

const authorize = (...allowedRoles) => {
    return async (req,res,next) => {
        try{
            const token = req.headers.authorization.split(' ')[1];
            const decoded = jwt.verify(token, process.env.ACCESS_TOKEN_SECRET);
            const user = await User.findById(decoded.user.id);

            if(!user){
                return res.status(404).json({message:"User not found"});
            }
            if(!allowedRoles.includes(user.role)){
                res.status(403).json({message:"Forbidden"})
            }
            req.user = user;
            next();
        }catch(error){
            res.status(401).json({message:"Not Authorized"});
        }
    }
}

module.exports = authorize;