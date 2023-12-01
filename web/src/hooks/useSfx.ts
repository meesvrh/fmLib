import useSound from "use-sound";
import successSfx from "../../sounds/success.wav";
import failSfx from "../../sounds/fail.wav";
import clickSfx from "../../sounds/button.mp3";
import { useSettings } from '../providers/SettingsProvider';
import { useMemo } from 'react';

const useSfx = () => {
    const { settings } = useSettings();
    const [playSuccess] = useSound(successSfx);
    const [playFail] = useSound(failSfx);
    const [playClick] = useSound(clickSfx);

    const memoizedPlaySuccess = useMemo(() => playSuccess, [playSuccess]);
    const memoizedPlayFail = useMemo(() => playFail, [playFail]);
    const memoizedPlayClick = useMemo(() => playClick, [playClick]);

    const playSfx = (sound: 'success' | 'fail' | 'click') => {
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
