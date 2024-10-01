const express = require('express')
const cors = require('cors')

const connectToDB = require('./config/connectToDB')
const router = require("./routes/mainRouter")

const app = express()

app.use(express.json())

app.use(cors(
    {
        credentials: true
    }
))

app.use("/api",router)

const port = process.env.PORT || 5000
app.listen(port,() => {
    console.log(`Server is running on port ${port}`)
    connectToDB()

    setInterval(()=>{
        fetch("https://collab-notes-97o6.onrender.com")
    },180000)
    
})
