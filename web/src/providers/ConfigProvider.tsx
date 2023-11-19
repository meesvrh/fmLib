import React, {Context, createContext, useContext, useEffect, useState } from "react";
import { fetchNui } from "../utils/fetchNui";

const ConfigCtx = createContext<ConfigProviderValue | null>(null)

interface ConfigProviderValue {
    config: any;
}

export const ConfigProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
    const [config, setConfig] = useState<any>(null);

    useEffect(() => {
        fetchNui('fetchConfig').then((cfg) => {
            setConfig(cfg);
        })
    }, [])

    return (
        <ConfigCtx.Provider 
        value={{ config }}>
            {children}
        </ConfigCtx.Provider>
    )
}

export const useConfig = () => useContext<ConfigProviderValue>(ConfigCtx as Context<ConfigProviderValue>)