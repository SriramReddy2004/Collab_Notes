import React from 'react'

const Button = ({ type, value, onclick }) => {
  return (
    <input type={type} value={value} className='w-[100%] h-[36px] bg-[rgba(187,0,255)] text-white cursor-pointer outline-none'  style={{boxShadow: '3px 3px 20px -5px #000'}}/>
  )
}

export default Button