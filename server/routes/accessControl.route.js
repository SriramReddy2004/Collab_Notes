const express = require('express');

const accessController = require("../controllers/access.controller")
const isValidToken = require("../middlewares/validToken.middleware")

const accessControlRouter = express.Router()

accessControlRouter.post("/give-access-by-username", isValidToken, accessController.giveAccessToUserByUsername)
accessControlRouter.post("/delete-permission", isValidToken, accessController.deletePermission)

module.exports = accessControlRouter