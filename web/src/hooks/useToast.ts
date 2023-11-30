import React, { useState, ReactNode } from "react";
import { toast } from "react-toastify";
import 'react-toastify/dist/ReactToastify.css';

interface ToastProps {
    type: 'success' | 'error' | 'info' | 'warning' | 'default'; 
    msg: string;
    position?: 'top-right' | 'top-center' | 'top-left' | 'bottom-right' | 'bottom-center' | 'bottom-left';
    theme?: 'light' | 'dark' | 'colored';
    autoClose?: number;
    hideProgressBar?: boolean;
    closeOnClick?: boolean;
    pauseOnHover?: boolean;
    draggable?: boolean;
    progress?: 0 | 1 | undefined;
}

export const useToast = () => {
    const sendToast = ({type, msg, position, theme, autoClose, hideProgressBar, closeOnClick, pauseOnHover, draggable, progress}: ToastProps) => {
        const params = {
            position: position || 'top-right',
            autoClose: autoClose || 5000,
            hideProgressBar: hideProgressBar || false,
            closeOnClick: closeOnClick || true,
            pauseOnHover: pauseOnHover || true,
            draggable: draggable || false,
            progress: progress || undefined,
            theme: theme || "dark",
        };

        switch (type) {
            case 'success':
                toast.success(msg, params);
                break;
            case 'error':
                toast.error(msg, params);
                break;
            case 'info':
                toast.info(msg, params);
                break;
            case 'warning':
                toast.warning(msg, params);
                break;
            case 'default':
                toast(msg, params);
                break;
            default:
                toast(msg, params);
                break;
        }
    };

    return {
        sendToast
    };
}