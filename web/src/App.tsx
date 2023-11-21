import React, {useEffect, useRef, useState} from 'react';
import Loading from './components/Loading';
import Dialog from './components/Dialog';
import { debugData } from './utils/debugData';

// debugData([
//   {
//     action: 'startLoading',
//     data: {},
//   }
// ])

export default function App() {

  return (
      <>
        <Dialog />
        <Loading />
      </>
  );
}