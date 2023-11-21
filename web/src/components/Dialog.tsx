import React from "react";
import { useEffect, useRef, useState } from "react";
import { useNuiEvent } from "../hooks/useNuiEvent";
import { fetchNui } from "../utils/fetchNui";
import { useDisclosure } from "@chakra-ui/react";
import {
    AlertDialog,
    AlertDialogBody,
    AlertDialogFooter,
    AlertDialogHeader,
    AlertDialogContent,
    AlertDialogOverlay,
    AlertDialogCloseButton,
  } from '@chakra-ui/react'

const Dialog = () => {
  const cancelRef = React.useRef();
  const [visible, setVisible] = useState(false);
  const { onOpen, onClose } = useDisclosure();
  const [title, setTitle] = useState<string>("");
  const [message, setMessage] = useState<string>("");
  const [cancelLabel, setCancelLabel] = useState<string>("Cancel");
  const [confirmLabel, setConfirmLabel] = useState<string>("Confirm");

  const handleCloseDialog = (res: boolean) => {
    setVisible(false);
    fetchNui("dialogClosed", res);
  };

  useNuiEvent("openDialog", (data) => {
    setVisible(true);
  });

  useNuiEvent("closeDialog", handleCloseDialog);

  return (
    <AlertDialog 
        motionPreset="slideInBottom"
        leastDestructiveRef={cancelRef}
        onClose={() => handleCloseDialog(false)}
        isOpen={visible}
        isCentered
    >


    </AlertDialog>
  );
};

export default Dialog;
