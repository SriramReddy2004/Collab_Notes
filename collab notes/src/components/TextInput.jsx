import React from 'react'

const TextInput = ({ name, register, type, placeholder, validation, errors }) => {
  return (
    <div>
      <div className={`w-[100%] h-[36px] border ${errors[name] && " border-red-800" || "border-black"} px-[5px] py-[5px]`}>
        <input type={ type } autoComplete='off' { ...register(name, validation ) } className='w-full outline-none' placeholder={ placeholder } />
      </div>
      { errors[name] && <span className='text-red-500'>{ errors[name]['message'] }</span> }
    </div>
  )
}

export default TextInput