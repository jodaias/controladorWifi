const express = require('express');
const cors = require('cors');
var bodyParser = require('body-parser')
const routes = require('./routes');
var cookieParser = require('cookie-parser');

const app = express();

// parse application/x-www-form-urlencoded
app.use(bodyParser.urlencoded({ extended: false }))

// parse application/json
app.use(bodyParser.json())

// parse application/vnd.api+json as json
app.use(bodyParser.json({ type: 'application/vnd.api+json' }))

app.use(cors());
app.use(cookieParser());
app.use(routes);

app.listen(3333);