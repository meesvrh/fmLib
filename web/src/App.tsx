import React, {useEffect, useRef, useState} from 'react';
import Loading from './components/Loading';
import Dialog from './components/Dialog';
import { debugData } from './utils/debugData';
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
        <Dialog />
        <Loading />
        <Progress />
      </div>
  );
}