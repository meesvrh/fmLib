import React, {Context, createContext, useContext, useEffect, useState } from "react";
import { fetchNui } from "../utils/fetchNui";

const LocalesCtx = createContext<LocalesProviderValue | null>(null)

interface LocalesProviderValue {
    _L: (key: string, ...params: any) => string;
}

export const LocalesProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
    const [locales, setLocales] = useState<any>(null);

    useEffect(() => {
        fetchNui('fetchLocales').then((lc) => {
            setLocales(lc);
        })
    }, [])

    const _L = (key: string, ...params: any) => {
        if (locales && locales[key]) {
            let localizedString = locales[key];
            for (let i = 0; i < params.length; i++) {
                localizedString = localizedString.replace('%s', params[i]);
            }
            return localizedString;
        } else {
            return 'Locale not found!';
        }
    };

    return (
        <LocalesCtx.Provider 
        value={{ _L }}>
            {children}
        </LocalesCtx.Provider>
    )
}

export const useLocales = () => useContext<LocalesProviderValue>(LocalesCtx as Context<LocalesProviderValue>)