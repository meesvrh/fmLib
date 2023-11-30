import useSound from "use-sound";
import successSfx from "../../sounds/success.wav";
import failSfx from "../../sounds/fail.wav";
import { useSettings } from '../providers/SettingsProvider';

const useSfx = () => {
    const { settings } = useSettings();
    const [playSuccess] = useSound(successSfx);
    const [playFail] = useSound(failSfx);

    const play = (sound: 'success' | 'fail') => {
        if (settings.useSfx) {
            switch (sound) {
                case 'success':
                    playSuccess();
                    break;
                case 'fail':
                    playFail();
                    break;
                default:
                    break;
            }
        }
    }

    return {
        play
    }
};

export default useSfx;