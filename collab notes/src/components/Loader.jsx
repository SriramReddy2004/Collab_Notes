import React from 'react'

const Loader = () => {
  return (
    <div className='relative w-[100%] h-[100vh] bg-[#0000005b] z-50'>
        <div className='absolute w-[150px] h-[50px] flex align-center justify-evenly bg-white top-2 left-[50%] translate-x-[-50%] rounded-md'>
            <div className='bg-[url("/src/assets/loader_gif.gif")] w-[50px] h-[50x] bg-fixed bg-contain bg-no-repeat bg-center' style={{backgroundSize: '400%'}}></div>
            <span className='w-fit h-[50px] pt-[10px] font-semibold text-black'>Loading...</span>
        </div>
    </div>
  )
}

export default Loader