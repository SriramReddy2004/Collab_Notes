import React, { useContext } from 'react'
import { useForm } from 'react-hook-form'
import TextInput from '../components/TextInput'
import { toast } from 'react-toastify'
import Button from '../components/Button'
import { useNavigate } from 'react-router-dom'
import { RegExps } from '../constants/regex'
import { LoaderContext } from '../App'
import axios from 'axios'
import Constants from '../constants/urls'

const Register = () => {

  const { register, handleSubmit, watch, formState: { errors } } = useForm()
  const navigate = useNavigate()

  const [ loading, setLoading ] = useContext(LoaderContext)

  const password = watch('password')

  const registerUser = async (data) => {
    setLoading(true)
    try{
      const response = await axios.post(`${Constants.serverUrl}/api/auth/register`,data)
      toast.success('User created successfully')
      setLoading(false)
      navigate('/login', { replace: true })
      return
    }
    catch(e){
      console.log(e)
    }
    setLoading(false)
  }

  return (
    <form onSubmit={handleSubmit(registerUser)} className='absolute top-[50%] left-[50%] translate-x-[-50%] translate-y-[-50%] w-[min(300px,95%)] h-fit p-[20px] border-2 rounded-md flex align-center justify-center flex-col gap-[20px]' style={{boxShadow: '0px 0px 10px #000'}}>
        <h1 className='text-2xl font-bold m-[auto] text-[rgba(187,0,255)]'>Register</h1>
        <TextInput
          name={"username"}
          placeholder={"Enter your username"}
          register={register}
          type={"text"}
          validation={{
            required: 'Username is required',
            minLength: {
              value: 3,
              message: 'Username must be at least 3 characters long',
            },
            maxLength: {
              value: 16,
              message: 'Username cannot exceed 16 characters',
            },
            pattern: {
              value: RegExps.username,
              message: 'username can only contain alphabets, numbers, symbols(_,-,.)',
            },
          }}
          errors={errors}
        />
        <TextInput
          name={"email"}
          placeholder={"Enter your email"}
          register={register}
          type={"email"}
          validation={{
            required: 'Email is required',
            pattern: {
              value: RegExps.email,
              message: 'Invalid email address',
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
              message: 'Password must be at least 6 characters',
            }
          }}
          errors={errors}
        />
        <TextInput
          name={"confirmPassword"}
          placeholder={"Confirm your password"}
          register={register}
          type={"password"}
          validation={{
            required: 'Password is required',
            minLength: {
              value: 6,
              message: 'Password must be at least 6 characters',
            },
            validate: (value) => password === value || "Both passwords must match"
          }}
          errors={errors}
        />
        <Button type={"submit"} value={"Register"} />
        <p className='m-auto'>Already have an account? <span className='text-[rgba(187,0,255)] cursor-pointer' onClick={()=>navigate('/login', { replace: true })}>Login</span></p>
    </form>
  )
}

export default Register