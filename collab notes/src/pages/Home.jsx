import React, { useContext, useEffect } from 'react'
import { LoaderContext } from '../App'
import axios from 'axios'
import Constants from '../constants/urls'

const Home = () => {

  const [ loading, setLoading ] = useContext(LoaderContext)

  const fetchAllNotes = async () => {
    try{
      const response = await axios.post(`${Constants.serverUrl}/api/get-all-notes-of-a-user`,{},{ withCredentials: true })
      console.log(response)
    }
    catch(e){
      console.log(e)
    }
  }

  useEffect(() => {
    fetchAllNotes()
  }, [])

  return (
    <div></div>
  )
}

export default Home