import React from "react";
import { Dialog } from "@material-ui/core";
import DialogContent from "@material-ui/core/DialogContent";
import DialogTitle from "@material-ui/core/DialogTitle";
import DialogActions from "@material-ui/core/DialogActions";
import Button from "@material-ui/core/Button";
import { styles } from "./styles.scss";

function ConfirmationModal({ chosenCandidate, open, setOpen }) {
  
  return (
    <Dialog
      onClose={() => setOpen(false)}
      open={open}
      maxWidth={false}
      aria-labelledby="confirmation-dialog-title"
      title={"Vote Confirmation"}
    >
      <div className={styles}>
        <DialogTitle id="confirmation-dialog-title">
          Vote Confirmation
        </DialogTitle>
        <DialogContent>{`Are you sure you want to vote for ${chosenCandidate}?`}</DialogContent>
        <DialogActions>
          <Button color="primary" onClick={() => setOpen(false)} variant="contained">
            Cancel
          </Button>
          <Button
            color="primary"
            onClick={() => console.log("submitted")}
            variant="contained"
          >
            OK
          </Button>
        </DialogActions>
      </div>
    </Dialog>
  );
}

export default ConfirmationModal;
