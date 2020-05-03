import React from "react";
import {
  Button,
  FormControl,
  Select,
  InputLabel,
  MenuItem,
} from "@material-ui/core";
import ConfirmationModal from "./components/ConfirmationModal";

import "./styles.scss";

function HomeView() {
  const [chosenCandidate, setChosenCandidate] = React.useState("");

  const submitVote = () => {};

  const register = () => {};

  return (
    <div className="home-centered">
      <div className="home-container">
        <div className="register">
          Welcome!
          <br />
          <Button
            style={{ marginTop: 20 }}
            variant="contained"
            color="primary"
            onClick={() => console.log("registered")}
          >
            Register
          </Button>
        </div>
        <hr />
        <div className="vote">
          <FormControl
            style={{ marginRight: 10, minWidth: 95, overflow: "hidden" }}
          >
            <InputLabel htmlFor="candidate-value">Candidate</InputLabel>
            <Select
              autoWidth
              value={chosenCandidate}
              color="primary"
              onChange={(e) => setChosenCandidate(e.target.value)}
              inputProps={{
                name: "candidate",
                id: "candidate-value",
              }}
            >
              {/* {databases.map((name) => (
    <MenuItem key={name} value={name}>
    {name}
    </MenuItem>
    ))} */}
            </Select>
          </FormControl>
          <Button
            style={{ marginTop: 10 }}
            variant="contained"
            color="primary"
            onClick={() => console.log("vote")}
          >
            Submit
          </Button>
        </div>
      </div>
    </div>
  );
}

export default HomeView;
