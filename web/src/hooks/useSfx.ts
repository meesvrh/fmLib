import useSound from "use-sound";
import successSfx from "../../sounds/success.wav";
import failSfx from "../../sounds/fail.wav";

export const useSfx = () => {
    const [playSuccess] = useSound(successSfx);
    const [playFail] = useSound(failSfx);

    return {
        playSuccess,
        playFail
    }
};
