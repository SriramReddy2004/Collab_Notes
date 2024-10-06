import React, { useContext } from 'react'
import { useForm } from 'react-hook-form'
import TextInput from '../components/TextInput'
import { toast } from 'react-toastify'
import Button from '../components/Button'
import { useNavigate } from 'react-router-dom'
import { LoaderContext } from '../App'
import axios from 'axios'
import Constants from '../constants/urls'
import { RegExps } from '../constants/regex'

const Login = () => {

  const { register, handleSubmit, formState: { errors } } = useForm()
  const navigate = useNavigate()

  const [loading, setLoading] = useContext(LoaderContext)

  const loginUser = async (formData) => {
    setLoading(true)
    try{
      const response = await axios.post(`${Constants.serverUrl}/api/auth/login`,formData)
      toast.success(response['data']['message'])
      localStorage.setItem("isLoggedIn", "true")
      localStorage.setItem("email", response['data']['email'])
      localStorage.setItem("username", response['data']['username'])
      setLoading(false)
      navigate('/')
      return
    }
    catch(e){
      toast.error(e['response']['data']['message'])
    }
    setLoading(false)
  }

  return (
    <form onSubmit={handleSubmit(loginUser)} className='absolute top-[50%] left-[50%] translate-x-[-50%] translate-y-[-50%] w-[min(300px,95%)] h-fit p-[20px] border-2 rounded-md flex align-center justify-center flex-col gap-[20px]' style={{boxShadow: '0px 0px 10px #000'}}>
        <h1 className='text-2xl font-bold m-[auto] text-[rgba(187,0,255)]'>Login</h1>
        <TextInput
          name={"username"}
          placeholder={"Enter your username"}
          register={register}
          type={"text"}
          validation={{
            required: 'Username is required',
            pattern: {
              value: RegExps.username,
              message: 'Invalid username',
            },
          }}
          errors={errors}
        />
        <TextInput
          name={"password"}
          placeholder={"Enter your password"}
          register={register}
          type={"password"}
          validation={{
            required: 'Password is required',
            minLength: {
              value: 6,
              message: 'Invalid password'
            }
          }}
          errors={errors}
        />
        <Button type={"submit"} value={"Login"} />
        <p className='m-auto'>Don't have an account? <span className='text-[rgba(187,0,255)] cursor-pointer' onClick={()=>navigate('/register', { replace: true })}>Register</span></p>
    </form>
  )
}

export default Login