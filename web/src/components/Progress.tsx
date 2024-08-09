import { useEffect, useRef, useState } from "react";
import { useNuiEvent } from "../hooks/useNuiEvent";
import { fetchNui } from "../utils/fetchNui";
import { CircularProgress, LinearProgress } from "@mui/joy";
import useSfx from "../hooks/useSfx";

const Progress = () => {
  const { playSfx } = useSfx();
  let timerInterval = useRef<NodeJS.Timeout | null>(null);
  const completedLabel = useRef<string>("COMPLETED");
  const failedLabel = useRef<string>("FAILED");
  const sfxEnabled = useRef<boolean>(true);
  const [transition, setTransition] = useState(false);
  const [visible, setVisible] = useState(false);
  const [label, setLabel] = useState<string>("");
  const [type, setType] = useState<"linear" | "circle">("linear");
  const [progress, setProgress] = useState<number>(0);
  const [color, setColor] = useState<"primary" | "success" | "danger">("primary");

  useEffect(() => {
    if (visible) {
      setTimeout(() => {
        setTransition(true);
      }, 100);
    }
  }, [visible]);

  const handleStopProgress = (success: boolean) => {
    if (timerInterval.current) clearInterval(timerInterval.current);
    if (sfxEnabled.current) {
      if (success) playSfx('success');
      else playSfx('fail');
    }
    setLabel(success ? completedLabel.current : failedLabel.current);
    setColor(success ? "success" : "danger");

    const stop = () => {
      setTimeout(() => {
        setTransition(false);

        setTimeout(() => {
          setVisible(false);
          fetchNui("progressStopped", success);
        }, 300);
      }, 500);
    };

    if (success && progress < 100) {
      const setProgressInterval = setInterval(() => {
        setProgress((prev) => {
          if (prev >= 100) {
            clearInterval(setProgressInterval);
            stop();
            return 100;
          }
          return prev + 1;
        });
      }, 10);
    } else if (!success && progress > 0) {
      const setProgressInterval = setInterval(() => {
        setProgress((prev) => {
          if (prev <= 0) {
            clearInterval(setProgressInterval);
            stop();
            return 0;
          }
          return prev - 1;
        });
      }, 10);
    } else {
      stop();
    }
  };

  useNuiEvent("startProgress", (data) => {
    sfxEnabled.current = data.useSfx;
    setLabel(data.label.toUpperCase());
    completedLabel.current = data.completedLabel.toUpperCase();
    failedLabel.current = data.failedLabel.toUpperCase();
    setType(data.type);
    setColor('primary');
    setProgress(0);

    setVisible(true);

    var interval = data.time / 100;
    var step = 1;

    if (interval >= 100) {
      interval /= 10;
      step /= 10;
    }

    timerInterval.current = setInterval(() => {
      setProgress((prev) => {
        if (prev >= 100) {
          handleStopProgress(true);
          return 100;
        }
        return prev + step;
      });
    }, interval);
  });

  useNuiEvent("stopProgress", handleStopProgress);

  return (visible &&
    <div className={`w-1/3 h-full flex justify-center items-end pb-8 transition-opacity duration-300 ease-in-out ${transition ? 'opacity-100' : 'opacity-0'}`}>
      {type === "circle" && (
        <>
          <div className="flex flex-col gap-2 items-center justify-center">
            <CircularProgress
              variant="soft"
              determinate
              value={progress}
              color={color}
              sx={{
                "--CircularProgress-size": "80px",
                "--CircularProgress-thickness": "8px",
              }}
            >
              <span className="font-semibold text-white">
                {Math.round(progress)}%
              </span>
            </CircularProgress>
            <span className="font-semibold text-white">
              {label && label}
            </span>
          </div>
        </>
      )}
      {type === "linear" && (
        <LinearProgress
          variant="soft"
          size="lg"
          determinate
          value={progress}
          color={color}
          sx={{
            "--LinearProgress-thickness": "24px",
          }}
        >
          <span className="font-semibold mix-blend-difference">
            {label && label} {Math.round(progress)}%
          </span>
        </LinearProgress>
      )}
    </div>
  );
};

export default Progress;