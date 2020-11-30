import React from 'react';
import { BrowserRouter, Route, Switch } from 'react-router-dom';

import AccessWifi from './pages/accesswifi';

export default function Routes() {
  return (
    <BrowserRouter>
      <Switch>
        <Route path="/" exact component={AccessWifi} />

      </Switch>
    </BrowserRouter>
  );
}
