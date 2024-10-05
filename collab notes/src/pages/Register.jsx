import React from 'react'
import { useForm } from 'react-hook-form'
import TextInput from '../components/TextInput'
import { toast } from 'react-toastify'
import Button from '../components/Button'
import { useNavigate } from 'react-router-dom'

const Register = () => {

  const { register, handleSubmit, formState: { errors } } = useForm()
  const navigate = useNavigate()

  const registerUser = (data) => {
    console.log(data)
    toast.success("Success")
  }

  return (
    <form onSubmit={handleSubmit(registerUser)} className='absolute top-[50%] left-[50%] translate-x-[-50%] translate-y-[-50%] w-[300px] h-fit p-[20px] border-2 rounded-md flex align-center justify-center flex-col gap-[20px]' style={{boxShadow: '0px 0px 10px #000'}}>
        <h1 className='text-2xl font-bold m-[auto] text-[rgba(187,0,255)]'>Register</h1>
        <TextInput
          name={"username"}
          placeholder={"Enter your username"}
          register={register}
          type={"text"}
          validation={{required: true}}
          errors={errors}
        />
        <TextInput
          name={"email"}
          placeholder={"Enter your email"}
          register={register}
          type={"email"}
          validation={{required: true}}
          errors={errors}
        />
        <TextInput
          name={"password"}
          placeholder={"Enter your password"}
          register={register}
          type={"password"}
          validation={{required: true}}
          errors={errors}
        />
        <TextInput
          name={"confirmPassword"}
          placeholder={"Confirm your password"}
          register={register}
          type={"password"}
          validation={{ required: true }}
          errors={errors}
        />
        <Button type={"submit"} value={"Register"} />
        <p className='m-auto'>Already have an account? <span className='text-[rgba(187,0,255)] cursor-pointer' onClick={()=>navigate('/login', { replace: true })}>Login</span></p>
    </form>
  )
}

export default Register