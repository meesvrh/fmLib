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

export const Dialog = () => {
  const [visible, setVisible] = useState(false);
  const [title, setTitle] = useState<string>("");
  const [message, setMessage] = useState<string>("");
  const [cancelLabel, setCancelLabel] = useState<string>("Cancel");
  const [confirmLabel, setConfirmLabel] = useState<string>("Confirm");
  const [size, setSize] = useState<'sm' | 'md' | 'lg'>('md');

  const handleCloseDialog = (res: 'cancel' | 'confirm') => {
    setVisible(false);
    fetchNui("dialogClosed", res);
  };

  useNuiEvent("openDialog", (data) => {
    setTitle(data.title);
    setMessage(data.message);
    setCancelLabel(data.cancelLabel);
    setConfirmLabel(data.confirmLabel);
    setSize(data.size);

    setVisible(true);
  });

  useNuiEvent("closeDialog", handleCloseDialog);

  return (
    <Transition in={visible} timeout={400}>
      {(state: string) => (
        <Modal
          keepMounted
          open={!["exited", "exiting"].includes(state)}
          onClose={() => handleCloseDialog('cancel')}
          hideBackdrop
          disableEscapeKeyDown
          sx={{
            visibility: state === "exited" ? "hidden" : "visible",
          }}
        >
          <ModalDialog
            variant="soft"
            role="alertdialog"
            size={size}
            sx={{
              opacity: 0,
              transition: `opacity 300ms`,
              ...{
                entering: { opacity: 1 },
                entered: { opacity: 1 },
              }[state],
            }}
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
        </Modal>
      )}
    </Transition>
  );
};