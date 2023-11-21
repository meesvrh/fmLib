import { useRef, useState } from "react";
import { useNuiEvent } from "../hooks/useNuiEvent";
import { fetchNui } from "../utils/fetchNui";
import { 
  CircularProgress,
  LinearProgress, 
  Stack, 
  Typography, 
} from "@mui/joy";

const Progress = () => {
  let timerInterval = useRef<NodeJS.Timeout | null>(null);
  const [visible, setVisible] = useState(false);
  const [label, setLabel] = useState<string>("");
  const [type, setType] = useState<'linear' | 'circle'>('linear');
  const [progress, setProgress] = useState<number>(0);

  const handleStopProgress = (success: boolean) => {
    setVisible(false);
    if (timerInterval.current) clearInterval(timerInterval.current);
    fetchNui("progressStopped", success);
  };

  useNuiEvent("startProgress", (data) => {
    setLabel((data.label).toUpperCase());
    setType(data.type);
    setProgress(0);

    setVisible(true);
    
    const interval = data.time / 100;
    timerInterval.current = setInterval(() => {
      setProgress((prev) => {
        if (prev >= 100) {
          handleStopProgress(true);
          return 0;
        }
        return prev + 1;
      });
    }, interval);
  });

  useNuiEvent("stopProgress", handleStopProgress);

  return (
    visible && (
      <div className="w-1/3 h-full flex justify-center items-end">
        {type === 'circle' && <>
          <div className="flex flex-col gap-2 items-center justify-center">
            <CircularProgress 
              variant="soft" 
              determinate 
              value={progress}
              sx={{
                '--CircularProgress-size': '80px',
                '--CircularProgress-radius': '8px',
                '--CircularProgress-thickness': '10px',
              }}
            >
              <Typography
                level='title-md'
              >
                {Math.round(progress)}%
              </Typography>
            </CircularProgress>
            <Typography
              level='title-md'
              textColor='common.white'
            >
              {label && label}
            </Typography>
          </div>
        </>}
        {type === 'linear' &&
          <LinearProgress 
            variant="soft" 
            size="lg" 
            determinate 
            value={progress}
            sx={{
              '--LinearProgress-radius': '20px',
              '--LinearProgress-thickness': '24px',
            }}
            >
            <Typography
              level='title-md'
              textColor='primary.500'
              sx={{ mixBlendMode: 'difference' }}
            >
              {label && label} {Math.round(progress)}%
            </Typography>
          </LinearProgress>
        }
      </div>
    )
  );
};

export default Progress;
