import React from 'react';
import { BrowserRouter, Route, Switch } from 'react-router-dom';

import AccessWifi from './pages/accesswifi';
import TermosWifi from './pages/termos';

export default function Routes() {
  return (
    <BrowserRouter>
      <Switch>
        <Route path="/" exact component={AccessWifi} />
        <Route path="/termos" component={TermosWifi} />
        <Route path="*" component={AccessWifi} />
      </Switch>
    </BrowserRouter>
  );
}
