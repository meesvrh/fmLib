import { useEffect, useRef, useState } from 'react';
import { useNuiEvent } from '../hooks/useNuiEvent';
import { fetchNui } from '../utils/fetchNui';
import { Spinner } from '@material-tailwind/react';
import { colors } from '@material-tailwind/react/types/generic';

const Loading = () => {
    console.log('Loading component loaded')
    let timerInterval = useRef<null | NodeJS.Timeout>(null);
    const [color, setColor] = useState<colors>('orange');
    const [size, setSize] = useState<number>(64);
    const [visible, setVisible] = useState(false);
    
    const stopLoading = (success: boolean) => {
        fetchNui('loadingStopped', success).then(() => {
            setVisible(false);
        })
    }
    
    useNuiEvent('startLoading', (data) => {
        setColor(data.color as colors);
        setSize(data.size);
    
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

    return (visible && 
    <div className='w-screen h-screen flex justify-center items-center bg-black/50'>
        <Spinner
            color={color}
            className={`w-[${size.toString()}px] h-[${size.toString()}px] text-dark`}
        />
    </div>
    );
}

export default Loading;