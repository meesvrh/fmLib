import useSound from "use-sound";
import successSfx from "../../assets/sounds/success.wav";
import failSfx from "../../assets/sounds/fail.wav";
import clickSfx from "../../assets/sounds/button.mp3";
import errorSfx from "../../assets/sounds/error.mp3";
import switchSfx from "../../assets/sounds/switch.mp3";
import { useSettings } from '../providers/SettingsProvider';
import { useMemo } from 'react';

const useSfx = () => {
    const { settings } = useSettings();
    const [playSuccess] = useSound(successSfx);
    const [playFail] = useSound(failSfx);
    const [playClick] = useSound(clickSfx);
    const [playError] = useSound(errorSfx);
    const [playSwitch] = useSound(switchSfx);

    const memoizedPlaySuccess = useMemo(() => playSuccess, [playSuccess]);
    const memoizedPlayFail = useMemo(() => playFail, [playFail]);
    const memoizedPlayClick = useMemo(() => playClick, [playClick]);
    const memoizedPlayError = useMemo(() => playError, [playError]);
    const memoizedPlaySwitch = useMemo(() => playSwitch, [playSwitch]);

    const playSfx = (sound: 'success' | 'fail' | 'click' | 'error' | 'switch') => {
        if (settings.useSfx) {
            switch (sound) {
                case 'success':
                    memoizedPlaySuccess();
                    break;
                case 'fail':
                    memoizedPlayFail();
                    break;
                case 'click':
                    memoizedPlayClick();
                    break;
                case 'error':
                    memoizedPlayError();
                    break;
                case 'switch':
                    memoizedPlaySwitch();
                    break;
                default:
                    break;
            }
        }
    };

    return {
        playSfx
    };
};

export default useSfx;
