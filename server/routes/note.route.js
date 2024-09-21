const express = require('express');

const noteController = require("../controllers/note.controller")
const isValidToken = require("../middlewares/validToken.middleware");

const noteRouter = express.Router()

noteRouter.post("/create-note", isValidToken, noteController.createNote)
noteRouter.post("/delete-note", isValidToken, noteController.deleteNote)
noteRouter.post("/update-note", isValidToken, noteController.updateNote)
noteRouter.post("/get-all-notes-of-a-user", isValidToken, noteController.getAllNotesOfaUser)
noteRouter.post("/get-permissions-of-a-note", isValidToken, noteController.getPermissionsOfaNote)

module.exports = noteRouter