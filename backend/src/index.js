const express = require('express');
const cors = require('cors');
const routes = require('./routes');
var cookieParser = require('cookie-parser');

const app = express();

app.use(cors());
app.use(cookieParser());
app.use(express.json());
app.use(routes);

app.listen(3333);