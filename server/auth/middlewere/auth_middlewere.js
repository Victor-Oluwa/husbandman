const jwt = require("jsonwebtoken");


const authMW = async (req, res, next) => {
    try {
        const token = req.header(process.env.USER_TOKEN);
        if (!token)
            return res
                .status(401)
                .json({ msg: "No authentication token found: Accesss denied." },);

        const verified = jwt.verify(token, process.env.PASSWORD_KEY);
        if (!verified)
            return res
                .status(401)
                .json({ msg: "Token verification failed, authorisation denied" });

        req.user = verified.id;
        req.token = token;
        next();

    } catch (e) {
        res.status(500).json({ error: e.message });

    }
}

module.exports = authMW;