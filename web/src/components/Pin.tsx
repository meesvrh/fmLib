import { useEffect, useRef, useState } from "react";
import { useNuiEvent } from "../hooks/useNuiEvent";
import { fetchNui } from "../utils/fetchNui";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faUnlock, faArrowLeft } from "@fortawesome/free-solid-svg-icons";
import useSfx from "../hooks/useSfx";

const Pin = () => {
  const { playSfx } = useSfx();
  const sfxEnabled = useRef<boolean>(true);
  const [transition, setTransition] = useState(false);
  const [props, setProps] = useState<any[any]>([]);
  const [pin, setPin] = useState<string>("");
  const [visible, setVisible] = useState(false);
  const [correctInput, setCorrectInput] = useState<boolean | null>(null);

  useEffect(() => {
    if (visible) {
      setTimeout(() => {
        setTransition(true);
      }, 100);

      const handleKeyDown = (event: any) => {
        if (event.key === "Escape" && props.canClose) {
          handleClosePin(false);
        } else if (event.key === "Enter") {
          handleClosePin(true);
        } else {
          handleKeyPress(event.key);
        }
      };

      window.addEventListener("keydown", handleKeyDown);

      return () => {
        window.removeEventListener("keydown", handleKeyDown);
      };
    }
  }, [visible]);

  const handleKeyPress = (key: string) => {
    setPin((prevPin) => {
      if (key === "Backspace") {
        const newPin = prevPin.slice(0, -1);
        const format = newPin.length > 0 ? newPin : "";
        setCorrectInput(null);
        return format;
      } else if (key >= "0" && key <= "9") {
        const newPin = prevPin + key;
        setCorrectInput(null);
        return newPin.length <= props.maxNumbers ? newPin : prevPin;
      } else {
        return prevPin;
      }
    });
  };

  const handleClosePin = (unlockBtn: boolean) => {
    let close: boolean = true;
    const reactive = props.reactiveUI
    const correctPin = reactive ? reactive.correctPin : null

    setPin((currentPin) => {
      const num = currentPin.trim() !== "" ? parseInt(currentPin, 10) : null;

      if (correctPin && correctPin !== num) {
        if (sfxEnabled.current) playSfx("error");
        setCorrectInput(false);
      } else if (correctPin && correctPin === num) {
        if (sfxEnabled.current) playSfx("success");
        setCorrectInput(true);
      } else {
        if (sfxEnabled.current) playSfx("switch");
      }
  
      if (reactive && !reactive.closeOnWrong && correctPin && correctPin !== num && unlockBtn) {
        close = false;
      }
  
      if (close) {
        setTransition(false);
    
        setTimeout(() => {
          fetchNui("pinClosed", num);
          setVisible(false);
        }, 300);
      }

      return currentPin;
    });

  };

  useNuiEvent("openPin", (data) => {
    sfxEnabled.current = data.useSfx;
    setPin("");
    setProps(data);
    setCorrectInput(null);
    setVisible(true);
  });

  useNuiEvent("closePin", () => handleClosePin(false));

  return (
    visible && (
      <div
        className={`w-full h-full flex justify-center items-center bg-black/50 transition-opacity duration-300 ease-in-out ${
          transition ? "opacity-100" : "opacity-0"
        }`}
      >
        <div className="bg-neutral-950 p-6 rounded-lg shadow-lg shadow-black">
          {(props.title || props.subtitle) && (
            <div className="flex flex-col justify-center items-center pb-6">
              {props.title && (
                <span className="text-2xl text-gray-400 font-bold">
                  {props.title}
                </span>
              )}
              {props.subtitle && (
                <span className="text-md text-gray-500">{props.subtitle}</span>
              )}
            </div>
          )}
          <div
            className={`w-[300px] flex items-center justify-center border h-[60px] mb-6 rounded-sm
              ${correctInput === false && "border-rose-900"}
              ${correctInput === true && "border-emerald-900"}
              ${correctInput === null && pin ? "border-[#e1c011]" : "border-gray-500"}
            `}
          >
            {pin && (
              <span
                className={`font-bold text-4xl tracking-widest
                  ${correctInput === false && "text-rose-500"}
                  ${correctInput === true && "text-emerald-500"}
                  ${correctInput === null && "text-[#e1c011]"}
                `}
                style={{
                  textShadow: `0 0 10px rgba(${
                    correctInput === false ? 255 : correctInput === true ? 46 : 225
                  }, ${
                    correctInput === false ? 0 : correctInput === true ? 139 : 192
                  }, ${
                    correctInput === false ? 0 : correctInput === true ? 34 : 17
                  }, 0.9)`,
                }}
              >
                {pin}
              </span>
            )}
          </div>
          <div className="flex flex-wrap justify-center items-center gap-3 px-2 max-w-[300px]">
            {Array.from({ length: 12 }, (_, index) => {
              const num = index == 10 ? 0 : index + 1;

              return (
                <div
                  key={index}
                  className={`cursor-pointer w-16 h-16 flex items-center justify-center border font-bold transition-all duration-300 ease-in-out
                    ${num === 10 && 'border-rose-900 text-rose-500 text-xl hover:border-rose-800 hover:text-rose-400'}
                    ${num === 12 && 'border-emerald-900 text-emerald-500 text-xl hover:border-emerald-800 hover:text-emerald-400'}
                    ${num !== 10 && num !== 12 && 'text-gray-500 border-neutral-900 hover:border-neutral-800 hover:text-gray-400 text-4xl'}
                  `}
                  onClick={() => num !== 10 && num !== 12 ? handleKeyPress(num.toString()) : num === 10 ? handleKeyPress('Backspace') : handleClosePin(true)}
                >
                  {num !== 10 && num !== 12 ? num : num === 10 
                    ? <FontAwesomeIcon icon={faArrowLeft} />
                    : <FontAwesomeIcon icon={faUnlock} />
                  }
                </div>
              );
            })}
          </div>
        </div>
      </div>
    )
  );
};

export default Pin;
