import React, {useEffect, useRef, useState} from 'react';
import Loading from './components/Loading';
import { debugData } from './utils/debugData';

debugData([
  {
    action: 'startLoading',
    data: {},
  }
])

export default function App() {

  return (
    <>
      <Loading />
    </>
  );
}