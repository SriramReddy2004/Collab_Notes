import { createContext, useContext, useState } from 'react'
import './App.css'
import Login from './pages/Login'
import Register from './pages/Register'
import { BrowserRouter as Router, Route, Routes, useNavigate, Navigate } from 'react-router-dom'
import { UserContext } from './main'
import Home from './pages/Home'
import NotFound from './pages/NotFound'
import Loader from './components/Loader'

export const  LoaderContext = createContext(null)

function App() {

  const user = useContext(UserContext)
  const [ loading, setLoading ] = useState(false)

  return (
    <LoaderContext.Provider value={[loading, setLoading]}>
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


              <Route path='/login' element={<Navigate to="/" replace={true} />}/>
              <Route path='/register' element={<Navigate to="/" replace={true} />}/>

              <Route path='*' element={<NotFound />}/>
            </>
          }
        </Routes>
      </Router>
      {loading && <Loader />}
    </LoaderContext.Provider>
  )
}

export default App
