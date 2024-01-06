import React, {useEffect, useRef, useState} from 'react';
import { debugData } from './utils/debugData';
import Loading from './components/Loading';
import Dialog from './components/Dialog';
import Pin from './components/Pin';
import Progress from './components/Progress';

// debugData([
//   {
//     action: 'startLoading',
//     data: {},
//   }
// ])

export default function App() {

  return (
      <div className='w-screen h-screen flex items-center justify-center'>
        <Pin />
        <Loading />
        <Dialog />
        <Progress />
      </div>
  );
}