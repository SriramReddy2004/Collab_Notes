const AccessControl = require("../models/accessControl.model");
const Note = require("../models/note.model");
const User = require("../models/user.model");

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
        const { _id } = req.user;
        const access = await AccessControl.findOne({ ownerId: _id, noteId: noteId, permission: "full" })
        if(access){
            await Promise.all([
                Note.findByIdAndDelete( noteId ),            // for concurrent execution
                AccessControl.deleteMany({ noteId })
            ])
            return res.status(200).json({"message": "Note deleted successfully"})
        }
        return res.status(400).json({"message": "Can't perform this operation"})
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

// const giveAccessToUserByUsername = async (req,res) => {
//     try{
//         const { noteId, username, access } = req.body
//         if(username === req.user.username){
//             return res.status(401).json({"message": "You have full permission on your notes"})
//         }
//         const { _id } = req.user;
//         const user = await User.findOne({ username })
//         if(user){
//             const accessControl = new AccessControl({ ownerId:_id, userId: user._id, noteId, permission: access })
//             await accessControl.save()
//             return res.status(200).json({"message": "Permission added successfully"})
//         }
//         return res.status(400).json({"message": "User doesnot exist"})
//     }
//     catch(e){
//         return res.status(500).json({"message": "Internal server error"})
//     }
// }

const updateNote = async (req,res) => {
    try{
        const { noteId, title, content } = req.body
        const { _id } = req.user
        const access = await AccessControl.findOne({ noteId: noteId, userId: _id })
        if(access){
            if(access.permission === "full" || access.permission === "write"){
                const updatedNote = await Note.findByIdAndUpdate({ _id: noteId }, { title, content })
                return res.status(200).json({"message": "Note updated successfully", "updatedNote": updatedNote})
            }
        }
        return res.status(401).json({"message": "You don't have permission to execute this operation"})
    }
    catch(e){
        return res.status(500).json({"message": "Internal server error"})
    }
}

const getPermissionsOfaNote = async (req,res) => {
    try{
        const { _id } = req.body
        const permissions = await AccessControl.find({ noteId: _id, permission: { $ne: "full" } }).populate("userId")
        return res.status(200).json(permissions)
    }
    catch(e){
        return res.status(500).json({"message": "Internal server error"})
    }
}

module.exports = { createNote, deleteNote, getAllNotesOfaUser, updateNote, getPermissionsOfaNote }