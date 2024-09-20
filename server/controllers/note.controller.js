const AccessControl = require("../models/accessControl.model");
const Note = require("../models/note.model");

const createNote = async (req,res) => {
    try{
        const { title, content } = req.body;
        const { _id } = req.user;
        const note = new Note({ title, content, createdBy: _id })
        const access = new AccessControl({ ownerId: _id, userId: _id, noteId: note._id, permission: "full" })
        await Promise.all([
            note.save(),            // for concurrent execution
            access.save()
        ])
        return res.status(200).json({"message": "Note created successfully"})
    }
    catch(e){
        console.log(e)
        return res.status(500).json({"message": "Internal server error"})
    }
}

const deleteNote = async (req,res) => {
    try{
        const { noteId } = req.body;
        await Promise.all([
            Note.findByIdAndDelete( noteId ),
            AccessControl.deleteMany({ noteId })
        ])
        return res.status(200).json({"message": "Note deleted successfully"})
    }
    catch(e){
        return res.status(500).json({"message": "Internal server error"})
    }
}

const getAllNotesOfaUser = async (req,res) => {
    try{
        const { _id } = req.user;
        const allNotes = await AccessControl.find({ userId: _id }).populate("noteId")
        return res.status(200).json(allNotes)
    }
    catch(e){
        return res.status(500).json({"message": "Internal server error"})
    }
}

module.exports = { createNote, deleteNote, getAllNotesOfaUser }