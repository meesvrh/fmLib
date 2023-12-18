import React, {Context, createContext, useContext, useEffect, useState } from "react";
import { fetchNui } from "../utils/fetchNui";
import { useNuiEvent } from "../hooks/useNuiEvent";

const SettingsCtx = createContext<SettingsProviderValue | null>(null)

interface SettingsProviderValue {
    settings: any;
}

export const SettingsProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
    const [settings, setSettings] = useState<any>(null);

    useEffect(() => {
        fetchNui('fetchSettings').then((data) => {
            setSettings(data.settings);
        })
    }, [])

    return (
        <SettingsCtx.Provider 
        value={{ settings }}>
            {children}
        </SettingsCtx.Provider>
    )
}

export const useSettings = () => useContext<SettingsProviderValue>(SettingsCtx as Context<SettingsProviderValue>)