import { useEffect, useRef, useState } from 'react';
import { useNuiEvent } from '../hooks/useNuiEvent';
import { fetchNui } from '../utils/fetchNui';
import Backdrop from '@mui/material/Backdrop';
import CircularProgress from '@mui/material/CircularProgress';
import LinearProgress from '@mui/material/LinearProgress';

const Loading = () => {
    let timerInterval = useRef<null | NodeJS.Timeout>(null);
    const [linear, setLinear] = useState<boolean>(false);
    const [visible, setVisible] = useState(false);
    
    const stopLoading = (success: boolean) => {
        fetchNui('loadingStopped', success).then((stopped) => {
            setVisible(false);
        })
    }
    
    useNuiEvent('startLoading', (data) => {
        setLinear(data.linear);
        setVisible(true);
        
        if (data.time === null) return
        let timeLeft = data.time
        
        timerInterval.current = setInterval(() => {
            timeLeft -= 1000
            if (timeLeft <= 0) {
                if (timerInterval.current) clearInterval(timerInterval.current)
                stopLoading(true)
            }
        }, 1000)
    })

    useNuiEvent('stopLoading', (visible) => {
        if (timerInterval.current) clearInterval(timerInterval.current)
        setVisible(visible);
    })

    return (
        <Backdrop
            sx={{ color: '#fff', zIndex: (theme) => theme.zIndex.drawer + 1 }}
            open={visible}
        >
            {linear ? <LinearProgress color="inherit"></LinearProgress> : <CircularProgress color="inherit" />}
        </Backdrop>
    );
}

export default Loading;