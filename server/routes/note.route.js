const express = require('express');

const noteController = require("../controllers/note.controller")
const isValidToken = require("../middlewares/validToken.middleware")

const noteRouter = express.Router()

noteRouter.post("/create-note", isValidToken, noteController.createNote)
noteRouter.post("/delete-note", isValidToken, noteController.deleteNote)
noteRouter.post("/get-all-notes-of-a-user", isValidToken, noteController.getAllNotesOfaUser)

module.exports = noteRouter