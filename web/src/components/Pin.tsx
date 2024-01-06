import { useEffect, useRef, useState } from "react";
import { useNuiEvent } from "../hooks/useNuiEvent";
import { fetchNui } from "../utils/fetchNui";
import useSfx from "../hooks/useSfx";

const Pin = () => {
  const { playSfx } = useSfx();
  const sfxEnabled = useRef<boolean>(true);
  const [transition, setTransition] = useState(false);
  const [props, setProps] = useState<any[any]>([]);
  const [pin, setPin] = useState<string>("");
  const [visible, setVisible] = useState(false);

  const handleKeyPress = (key: string) => {
    setPin((prevPin) => {
      if (key === "Backspace") {
        const newPin = prevPin.slice(0, -1);
        return newPin.length > 0 ? newPin : "";
      } else if (key >= "0" && key <= "9") {
        const newPin = prevPin + key;
        return newPin.length <= props.maxNumbers ? newPin : prevPin;
      } else {
        return prevPin;
      }
    });
  };

  useEffect(() => {
    if (visible) {
      setTimeout(() => {
        setTransition(true);
      }, 100);

      const handleKeyDown = (event: any) => {
        if (event.key === "Escape" || event.key === "Enter") {
          handleClosePin();
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

  const handleClosePin = () => {
    setTimeout(() => {
      setTransition(false);

      setTimeout(() => {
        setPin((currentPin) => {
        const num = currentPin.trim() !== "" ? parseInt(currentPin, 10) : null;

          fetchNui("pinClosed", num);
          setVisible(false);

          return currentPin;
        });
      }, 300);
    });
  };

  useNuiEvent("openPin", (data) => {
    sfxEnabled.current = data.useSfx;
    setPin("");
    setProps(data);
    setVisible(true);
  });

  useNuiEvent("closePin", handleClosePin);

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
            className={`w-[300px] flex items-center justify-center border h-[60px] mb-6 rounded-sm ${
              pin ? "border-[#e1c011]" : "border-gray-500"
            }`}
          >
            {pin && (
              <span
                className="text-[#e1c011] font-bold text-4xl tracking-widest"
                style={{ textShadow: "0 0 10px rgba(225, 192, 17, 0.9)" }}
              >
                {pin}
              </span>
            )}
          </div>
          <div className="flex flex-wrap justify-center items-center gap-3 px-2 max-w-[300px]">
            {Array.from({ length: 10 }, (_, index) => {
              const num = index == 9 ? 0 : index + 1;

              return (
                <div
                  key={index}
                  className="cursor-pointer w-16 h-16 flex items-center justify-center border border-neutral-900 text-4xl text-gray-500 font-bold transition-all duration-300 ease-in-out hover:border-neutral-800 hover:text-gray-400"
                  onClick={() => handleKeyPress(num.toString())}
                >
                  {num}
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
