import { useContext } from 'react'
import './App.css'
import Login from './pages/Login'
import Register from './pages/Register'
import { BrowserRouter as Router, Route, Routes, useNavigate, Navigate } from 'react-router-dom'
import { UserContext } from './main'
import Home from './pages/Home'

function App() {

  const user = useContext(UserContext)

  return (
    <>
      <Router>
        <Routes>
          {
            (user.isLoggedIn==="false")?
            <>
              <Route path="/login" element={ <Login /> } />
              <Route path="/register" element={ <Register /> } />

              <Route path='*' element={<Navigate to="/login" replace={true} />}/>
            </>:
            <>
              <Route path="/" element={ <Home /> } />

              <Route path='*' element={<Navigate to="/" replace={true} />}/>
            </>
          }
        </Routes>
      </Router>
    </>
  )
}

export default App
