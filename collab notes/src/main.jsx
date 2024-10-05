import { createContext, StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import App from './App.jsx'
import './index.css'
import 'react-toastify/dist/ReactToastify.css';
import { ToastContainer } from 'react-toastify';

export const UserContext = createContext({})

if(window.localStorage.getItem("isLoggedIn")===null) window.localStorage.setItem("isLoggedIn", false)

const user = window.localStorage

createRoot(document.getElementById('root')).render(
  <StrictMode>
    <UserContext.Provider value={ user }>
      <App />
    </UserContext.Provider>
    <ToastContainer />
  </StrictMode>
)
