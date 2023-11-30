import { useRef, useState } from "react";
import { useNuiEvent } from "../hooks/useNuiEvent";
import { fetchNui } from "../utils/fetchNui";
import { CircularProgress, LinearProgress, Typography } from "@mui/joy";

const Progress = () => {
  let timerInterval = useRef<NodeJS.Timeout | null>(null);
  const [visible, setVisible] = useState(false);
  const [label, setLabel] = useState<string>("");
  const [type, setType] = useState<"linear" | "circle">("linear");
  const [progress, setProgress] = useState<number>(0);
  const [completedLabel, setCompletedLabel] = useState<string>("COMPLETED");
  const [failedLabel, setFailedLabel] = useState<string>("FAILED");
  const [color, setColor] = useState<"primary" | "success" | "danger">("primary");

  const handleStopProgress = (success: boolean) => {
    if (timerInterval.current) clearInterval(timerInterval.current);
    setLabel(success ? completedLabel : failedLabel);
    setColor(success ? "success" : "danger");

    const stop = () => {
      setTimeout(() => {
        setVisible(false);
        fetchNui("progressStopped", success);
      }, 1000);
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
    setLabel(data.label.toUpperCase());
    setCompletedLabel(data.completedLabel.toUpperCase());
    setFailedLabel(data.failedLabel.toUpperCase());
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

  return (
    visible && (
      <div className="w-1/3 h-full flex justify-center items-end pb-8">
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
                <Typography level="title-md">
                  {Math.round(progress)}%
                </Typography>
              </CircularProgress>
              <Typography level="title-md" textColor="common.white">
                {label && label}
              </Typography>
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
            <Typography
              level="title-md"
              textColor="primary.500"
              sx={{ mixBlendMode: "difference" }}
            >
              {label && label} {Math.round(progress)}%
            </Typography>
          </LinearProgress>
        )}
      </div>
    )
  );
};

export default Progress;
