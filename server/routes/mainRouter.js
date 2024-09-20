const express = require('express')
const authRouter = require('./auth.route')
const noteRouter = require('./note.route')

const router = express.Router()

router.use("/auth",authRouter)
router.use(noteRouter)

module.exports = router