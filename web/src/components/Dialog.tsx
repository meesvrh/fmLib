import { useEffect, useRef, useState } from "react";
import { useNuiEvent } from "../hooks/useNuiEvent";
import { fetchNui } from "../utils/fetchNui";
import { Transition } from "react-transition-group";
import Modal from "@mui/joy/Modal";
import ModalDialog from "@mui/joy/ModalDialog";
import DialogTitle from "@mui/joy/DialogTitle";
import DialogContent from "@mui/joy/DialogContent";
import DialogActions from "@mui/joy/DialogActions";
import Button from "@mui/joy/Button";
import Divider from "@mui/joy/Divider";
import useSfx from "../hooks/useSfx";

const Dialog = () => {
  const { playSfx } = useSfx();
  const sfxEnabled = useRef<boolean>(true);
  const [transition, setTransition] = useState(false);
  const [visible, setVisible] = useState(false);
  const [title, setTitle] = useState<string>("");
  const [message, setMessage] = useState<string>("");
  const [cancelLabel, setCancelLabel] = useState<string>("Cancel");
  const [confirmLabel, setConfirmLabel] = useState<string>("Confirm");
  const [size, setSize] = useState<'sm' | 'md' | 'lg'>('md');

  useEffect(() => {
    if (visible) {
      setTimeout(() => {
        setTransition(true);
      }, 100);
    }
  }, [visible]);

  const handleCloseDialog = (res: 'cancel' | 'confirm') => {
    if (sfxEnabled.current) playSfx('click');

    setTransition(false);

    setTimeout(() => {
      setVisible(false);
      fetchNui("dialogClosed", res);
    }, 300);
  };

  useNuiEvent("openDialog", (data) => {
    sfxEnabled.current = data.useSfx;
    setTitle(data.title);
    setMessage(data.message);
    setCancelLabel(data.cancelLabel);
    setConfirmLabel(data.confirmLabel);
    setSize(data.size);

    setVisible(true);
  });

  useNuiEvent("closeDialog", handleCloseDialog);

  return (visible &&
      <Modal
        keepMounted
        open={visible}
        onClose={() => handleCloseDialog('cancel')}
        hideBackdrop
        disableEscapeKeyDown
      >
      <div className={`w-full h-full transition-opacity duration-300 ease-in-out ${transition ? 'opacity-100' : 'opacity-0'} `}>
        <ModalDialog
          variant="soft"
          role="alertdialog"
          size={size}
        >
          <DialogTitle>{title}</DialogTitle>
          <Divider />
          <DialogContent>{message}</DialogContent>
          <DialogActions>
            <Button
              variant="solid"
              onClick={() => handleCloseDialog('confirm')}
            >
              {confirmLabel}
            </Button>
            <Button
              variant="plain"
              color="danger"
              onClick={() => handleCloseDialog('cancel')}
            >
              {cancelLabel}
            </Button>
          </DialogActions>
        </ModalDialog>
      </div>
    </Modal>
  );
};

export default Dialog;