import React, { Component } from "react";
import { withRouter } from "react-router-dom";
import AppBar from "components/AppBar";
import Typography from "components/Typography";
import Toolbar from "@material-ui/core/Toolbar";
import { appConfig } from "configs/config-main";
import "./styles.scss";

function Header() {
  return (
    <div>
      <AppBar>
        <Toolbar>
          <Typography variant="title" color="inherit">
            <div className="top">
              &#10031; &#10031; &#10031; &#10031; &#10031; &#10031; &#10031;
              &#10031; &#10031; {appConfig.name} &#10031; &#10031; &#10031;
              &#10031; &#10031; &#10031; &#10031; &#10031; &#10031;
            </div>
          </Typography>
        </Toolbar>
      </AppBar>
    </div>
  );
}

export default withRouter(Header);
