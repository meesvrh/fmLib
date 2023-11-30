import useSound from "use-sound";
import successSfx from "../../sounds/success.wav";
import failSfx from "../../sounds/fail.wav";
import { useSettings } from '../providers/SettingsProvider';
import { useMemo } from 'react';

const useSfx = () => {
    const { settings } = useSettings();
    const [playSuccess] = useSound(successSfx);
    const [playFail] = useSound(failSfx);

    const memoizedPlaySuccess = useMemo(() => playSuccess, [playSuccess]);
    const memoizedPlayFail = useMemo(() => playFail, [playFail]);

    const playSfx = (sound: 'success' | 'fail') => {
        if (settings.useSfx) {
            switch (sound) {
                case 'success':
                    memoizedPlaySuccess();
                    break;
                case 'fail':
                    memoizedPlayFail();
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
